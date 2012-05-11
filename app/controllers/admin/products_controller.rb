class Admin::ProductsController < ApplicationController

  before_filter :login_required, :admin_login_required

  def index
  end

  def edit
    @product = Product.find(params[:id], :include => [:ds_vendor, :product_images])
    @breadcrumb = @product.category.breadcrumb
    @related_products = Product.find(:all, :conditions => [ 'products.manufacturer = ? and products.id != ?', @product.manufacturer, @product.id], :limit => 4, :include => :product_images) 
  end

  def update
    @product = Product.find(params[:id], :include => [:ds_vendor, :product_images])
    if @product.update_attributes(params[:product])
      redirect_to product_path(@product)
    else
      flash[:notice] = "There was a problem"
      @breadcrumb = @product.category.breadcrumb
      @related_products = Product.find(:all, :conditions => [ 'products.manufacturer = ? and products.id != ?', @product.manufacturer, @product.id], :limit => 4, :include => :product_images) 
      render :action => 'edit'
    end
  end
end
