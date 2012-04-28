class SearchController < ApplicationController

  def post
    redirect_to :action => :index, :controller => :products and return if params[:id].nil?
    redirect_to :action => :show, :id => params[:id].parameterize('+') and return
  end

  def show
    redirect_to :action => :index, :controller => :products and return if params[:id].nil?
    if params[:id].include?(' ')
      redirect_to :action => :show, :id => params[:id].parameterize('+') and return
    end
    redirect_to :action => :index, :controller => :products and return if params[:id].nil?
    @terms = params[:id].gsub(/\+/, ' ') #turn +'s back into spaces for searching again - and for the query
    page = params[:page] || 1
    @count = Cache.get 'search_' + params[:id].to_s + '_page_' + page.to_s + '_count'
    unless @count
      @count  = Product.count(:all, :conditions => [ "match(title, description, manufacturer) against (?)", @terms])
      if @count == 0
        @aterms = ''
        sterms = params[:id].split('+') 
        sterms.each do |term|
          @aterms = @aterms + '%' + term
        end
        @aterms = @aterms + "%"
        @count =  Product.count(:all, :conditions => [ "title like ? or description like ? or manufacturer like ?", @aterms, @aterms, @aterms])
      end
      Cache.put 'search_' + params[:id].to_s + '_page_' + page.to_s + '_count', @count
    end

    @products = Cache.get 'search_' + params[:id].to_s + '_page_' + page.to_s
    unless @products
      @products = Product.paginate(:page => page, :conditions => [ "match(title, description, manufacturer) against (?)", @terms], :include => :product_images)
      if @products.empty?
        @products = Product.paginate(:page => page, :conditions => [ "title like ? or description like ? or manufacturer like ?", @aterms, @aterms, @aterms], :include => :product_images)
      end
      Cache.put 'search_' + params[:id].to_s + '_page_' + page.to_s, @products
    end
  end
end
