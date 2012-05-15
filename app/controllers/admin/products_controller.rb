class Admin::ProductsController < ApplicationController

  before_filter :login_required, :admin_login_required

  def index
  end

  def edit
    @product = Product.find(params[:id], :include => [:ds_vendor, :product_images])
    @manufacturers = Manufacturer.all
    @product_image = @product.product_image
    @breadcrumb = @product.category.breadcrumb
    @categories = Category.all
    @related_products = Product.find(:all, :conditions => [ 'products.manufacturer_id = ? and products.id != ?', @product.manufacturer_id, @product.id], :limit => 4, :include => [:product_image,:product_images]) 
  end

  def update
    @product = Product.find(params[:id], :include => [:ds_vendor, :product_image, :product_images])
    @product_image = @product.product_image
    @product.assign_attributes(params[:product], :as => :admin)
    if @product.save
      if params[:product_image] and ! params[:product_image].empty?
        @product.product_images.each do |im|
          im.destroy
        end
        @product_image = ProductImage.new
        @product_image.assign_attributes(params[:product_image].merge( {:hero => true} ), :as => :admin)
        @product_image.product = @product
        if @product_image.save
          redirect_to product_path(@product) and return
        else
          puts 'errors in product image save'
        end
      end
      redirect_to product_path(@product) and return
    end
    flash[:notice] = "There was a problem"
    @categories = Category.all
    @breadcrumb = @product.category.breadcrumb
    @related_products = Product.find(:all, :conditions => [ 'products.manufacturer = ? and products.id != ?', @product.manufacturer, @product.id], :limit => 4, :include => :product_images) 
    render :action => 'edit'
  end
end
