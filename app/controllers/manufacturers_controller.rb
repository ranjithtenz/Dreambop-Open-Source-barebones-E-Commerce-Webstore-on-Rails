class ManufacturersController < ApplicationController

  def index
    @manufacturers = Cache.get 'manufacturers' 
    unless @manufacturers
      @manufacturers = Manufacturer.all
      Cache.put 'manufacturers', @manufacturers
    end
  end

  def show
    redirect_to :action => :index and return if params[:id].nil? or params[:id].empty?
    @manufacturer = Manufacturer.find(params[:id])
    page = params[:page] || 1
    @products = Cache.get 'manufacturer_' + params[:id] + '_products_page' + page.to_s
    unless @products
      @products = Product.paginate( { :page => page, :conditions => [ 'manufacturer_id = ?', @manufacturer.id.to_s], :order => 'msrp ASC', :include => :product_images})
      Cache.put 'manufacturer_' + params[:id] + '_products_page' + page.to_s, @products
    end
  end

end
