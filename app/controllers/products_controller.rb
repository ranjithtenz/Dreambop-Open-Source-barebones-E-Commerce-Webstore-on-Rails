class ProductsController < ApplicationController
  def feed
    @products = Cache.get 'products_feed' 
    unless @products
      @products = Product.find(:all, :limit => 10)
      Cache.put 'products_feed', @products
    end
    respond_to do |format|
      format.rss  { render :layout => false }
      format.xml { render 'feed.rss', :layout => false}
    end
  end

  # GET /products
  # GET /products.xml
  def index
    page = params[:page] || 1
    @featured_products = Cache.get 'featured_prod_8'
    unless @featured_products
      @featured_products = Product.find( :all, {:limit => 8, :conditions => ['category_id = 272'], :order => 'msrp ASC', :include => :product_images})
      Cache.put 'featured_prod_8', @featured_products
    end
    @new_products = Cache.get 'new_prod_8'
    unless @new_products
      @new_products = Product.find( :all, {:limit => 8, :order => 'created_at DESC', :include => :product_images})
      Cache.put 'new_prod_8', @new_products
    end
    @top_sellers = Cache.get 'top_seller_8'
    unless @top_sellers
      @top_sellers  = Product.find( :all, {:limit => 8, :conditions => [ 'category_id in (564, 567)'], :order => 'msrp, created_at DESC', :include => :product_images})
      Cache.put 'top_seller_8', @top_sellers
    end
    @recommended = Cache.get 'recommended_8'
    unless @recommended
      @recommended = Product.find( :all, {:limit => 8, :conditions => [ 'category_id = 274'], :order => 'msrp, created_at DESC', :include => :product_images})
      Cache.put 'recommended_8', @recommended
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end
  
  def featured
    @section_title = "FEATURED PRODUCTS"
    page = params[:page] || 1
    @products = Cache.get 'featured_prod_pg_' + page.to_s
    unless @products
      @products = Product.paginate( {:page => page, :conditions => ['category_id = 272'], :order => 'msrp ASC', :include => :product_images})
      Cache.put 'featured_prod_pg_' + page.to_s, @products
    end
  end

  def new
    @section_title = "NEWEST PRODUCTS"
    page = params[:page] || 1
    @products = Cache.get 'newest_prod_pg_' + page.to_s
    unless @products
      @products = Product.paginate( { :page => page, :order => 'created_at DESC', :include => :product_images})
      Cache.put 'newest_prod_pg_' + page.to_s, @products
    end
    render :featured
  end

  def top_sellers
    @section_title = "TOP SELLERS"
    page = params[:page] || 1
    @products = Cache.get 'top_prod_pg_' + page.to_s
    unless @products
      @products = Product.paginate( { :page => page, :conditions => [ 'category_id in (564, 567)'], :order => 'msrp ASC', :include => :product_images})
      Cache.put 'top_prod_pg_' + page.to_s, @products
    end
    render :featured
  end

  def recommended
    @section_title = "RECOMMENDED PRODUCTS"
    page = params[:page] || 1
    @products = Cache.get 'rec_prod_pg_' + page.to_s
    unless @products
      @products = Product.paginate( { :page => page, :conditions => [ 'category_id = 274'], :order => 'msrp, created_at DESC', :include => :product_images})
      Cache.put 'rec_prod_pg_' + page.to_s, @products
    end
    render :featured
  end
  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Cache.get 'product_' + params[:id].to_s
    unless @product
      begin
        @product = Product.find(params[:id], :include => [:ds_vendor, :product_images])
      rescue
        flash[:notice] = "I'm sorry. We couldn't find the product you were looking for"
        redirect_to '/' and return 
      end
      Cache.put 'product_' + params[:id].to_s, @product
    end
    @breadcrumb = Cache.get 'product_' + params[:id].to_s + '_breadcrumb'
    unless @breadcrumb
      @breadcrumb = @product.category.breadcrumb
      Cache.put 'product_' + params[:id].to_s + '_breadcrumb', @breadcrumb
    end
    @related_products = Product.find(:all, :conditions => [ 'products.manufacturer = ? and products.id != ?', @product.manufacturer, @product.id], :limit => 4, :include => :product_images) 

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
=begin
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end
=end

  # GET /products/1/edit
=begin
  def edit
    @product = Product.find(params[:id])
  end
=end

  # POST /products
  # POST /products.xml
=begin
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end
=end

  # PUT /products/1
  # PUT /products/1.xml
=begin
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end
=end

  # DELETE /products/1
  # DELETE /products/1.xml
=begin
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
=end
end
