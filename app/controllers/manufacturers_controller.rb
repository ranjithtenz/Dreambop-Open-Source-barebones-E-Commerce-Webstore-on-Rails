class ManufacturersController < ApplicationController

  def index
    @manufacturers = Cache.get 'manufacturers' 
    unless @manufacturers
      @manufacturers = Product.find(:all, :select => 'DISTINCT manufacturer', :include => :product_images) 
      Cache.put 'manufacturers', @manufacturers
    end
  end

  def show
    redirect_to :action => :index and return if params[:id].nil? or params[:id].empty?
    @manufacturer = params[:id].gsub(/\+/, ' ')
    page = params[:page] || 1
    @products = Cache.get 'manufacturer_' + params[:id] + '_products_page' + page.to_s
    unless @products
      @products = Product.paginate( { :page => page, :conditions => [ 'manufacturer = ?', @manufacturer], :order => 'msrp ASC', :include => :product_images})
      Cache.put 'manufacturer_' + params[:id] + '_products_page' + page.to_s, @products
    end
  end

end
