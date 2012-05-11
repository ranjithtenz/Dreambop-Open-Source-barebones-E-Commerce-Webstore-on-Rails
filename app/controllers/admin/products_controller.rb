class Admin::ProductsController < ApplicationController

  before_filter :login_required, :admin_login_required

  def index
  end

  def edit
    @product = Product.find(params[:id], :include => [:ds_vendor, :product_images])
    @product_image = @product.product_image
    @breadcrumb = @product.category.breadcrumb
    @related_products = Product.find(:all, :conditions => [ 'products.manufacturer = ? and products.id != ?', @product.manufacturer, @product.id], :limit => 4, :include => [:product_image,:product_images]) 
  end

  def update
    @product = Product.find(params[:id], :include => [:ds_vendor, :product_image, :product_images])
    @product_image = @product.product_image
    if @product.update_attributes(params[:product])
      if params[:product_image]
        puts 'in cont: product_image'
        @product_image = ProductImage.new(params[:product_image])
        puts 'in cont: product_image new'
        @product_image.product = @product
        if @product_image.save
          redirect_to product_path(@product) and return
        else
          puts 'errors in product image save'
        end
      end
    end
    flash[:notice] = "There was a problem"
    @breadcrumb = @product.category.breadcrumb
    @related_products = Product.find(:all, :conditions => [ 'products.manufacturer = ? and products.id != ?', @product.manufacturer, @product.id], :limit => 4, :include => :product_images) 
    render :action => 'edit'
  end
end
