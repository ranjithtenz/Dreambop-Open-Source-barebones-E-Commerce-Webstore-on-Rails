require 'fileutils'
include MiniMagick
#include Magick

class ProductImage < ActiveRecord::Base
  attr_accessible :remote_file, :hero, :as => :admin
  
  acts_as_tree :order => "filename"

  belongs_to :product

  before_create :create_local_copy

#  has_attachment :storage => :s3, 
#                 :thumbnails => { :thumb => [150], :geometry => 'x150' }, 
#                 :content_type => :image

  attr_accessor :remote_file

  BUCKET = 'dreambop'

  def local_file
    ldir = File.join("/images", "products")
    location = File.join(ldir, self.filename)
  end

  def public_filename
    location = 'https://s3.amazonaws.com/' + BUCKET + '/' + self.filename
  end

  def create_local_copy
    return true if self.thumbnail
    file = File.join("public", self.remote_file.path)
    ftype = File.extname( self.remote_file.original_filename )
    self.filename = self.product.id.to_s + '-' + self.product.title.parameterize.to_s + ftype 
    validates_length_of(:filename, :minimum => 4)
    ldir = File.join(Rails.root, "public", "images", "products", self.filename)
    File.open(ldir, "wb") { |f| f.write(File.open(self.remote_file.path).read)}
    self.content_type = File.extname( self.filename )
    #make_x75
  end

  def make_x75
    buffer = StringIO.new(File.open(self.remote_file.path,"rb") { |f| f.read })
    image = MiniMagick::Image.read(buffer)
    image_tn75 = image.resize( "75x" )
    image_fn = self.product.id.to_s + '-' + self.product.title.parameterize.to_s + "-x75" + self.content_type
    image_lp = File.join(Rails.root, "public", "images", "products", image_fn)
    image_tn75.write(image_fn)
    ni = ProductImage.create(:filename => image_fn, :content_type => self.content_type, :hero => self.hero, :product => self.product, :parent => self, :thumbnail => true, :width => 75 )
  end

  def create_thumbnails
=begin
    FileUtils.cp file, Rails.root + '/zimage.jpg'
    FileUtils.rm file
    image = MiniMagick::Image.open( self.local_file.tempfile )
    self.content_type = self.content_type.downcase
    self.filename = self.product.id +    
    puts 'here'
    image.write( Rails.root + '/public/images/products/' + self.local_file )
    image_tn300 = image.resize( "300x" )
    image_tn300.write( Rails.root + '/public/images/products/' + self.local_file )
    #if self.width != 150
    #p_image = ProductImage.new(:parent_id => self.id, :filename => image_150_name, :content_type => self.content_type,  :product => self.product, :width => '150', :thumbnail => 1)
    #image_tn150 = image.resize( "150x" )
    #image_tn75 = image.resize( "75x" )
=end
  end

  def old_create_thumbs!
    AWS::S3::Base.establish_connection!(
      :access_key_id     => 'FF00FFUUFFUUFFUUFUU00',
      :secret_access_key => '7373784848477383847748847'
    )
    self.content_type = content_type = self.content_type.downcase
    new_file_name = self.filename + '-x' + self.width.to_s + self.content_type
    AWS::S3::S3Object.store(new_file_name, open(self.local_file), BUCKET, :access => :public_read)
    local_dir = File.dirname(self.local_file)
    location = 'https://s3.amazonaws.com/' + BUCKET + '/' + new_file_name
    if self.width != 150
      image_150_name = self.filename + '-x150' + self.content_type
      p_image = ProductImage.new(:parent_id => self.id, :filename => image_150_name, :content_type => self.content_type,  :product => self.product, :width => '150', :thumbnail => 1)
      p_image.save!
      img = Image.read(local_file).first
      new_img = img.change_geometry('150x150') { |cols, rows, b_img| b_img.resize(cols, rows) } 
      local_150 = local_dir + '/' + image_150_name
      new_img.write(local_150)
      AWS::S3::S3Object.store(image_150_name, open(local_150), BUCKET, :access => :public_read)
      img.destroy!
      File.delete(local_150)
    end
    image_75_name = self.filename + '-x75' + self.content_type
    p_image = ProductImage.create(:parent_id => self.id, :filename => image_75_name, :content_type => self.content_type,  :product => self.product, :width => '75', :thumbnail => 1)
    img = Image.read(local_file).first
    new_img = img.change_geometry('75x75') { |cols, rows, b_img| b_img.resize(cols, rows) } 
    local_75 = local_dir + '/' + image_75_name
    new_img.write(local_75)
    AWS::S3::S3Object.store(image_75_name, open(local_75), BUCKET, :access => :public_read)
    img.destroy!
    File.delete(local_75)
    self.filename = new_file_name
    self.save!
  end

end
