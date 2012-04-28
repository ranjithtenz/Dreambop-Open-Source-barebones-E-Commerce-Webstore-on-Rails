class CategoriesController < ApplicationController

  def sub
    @category = params[:id]
    @category = "all" if @category.nil? or @category == '' or @category == "All"
    @category = Cache.get 'category_' + @category
    unless @category
      @category = Category.find_by_name(params[:id])
      Cache.put 'category_' + @category.name, @category
    end

    @breadcrumb = Cache.get 'product_' + params[:id].to_s + '_breadcrumb'
    unless @breadcrumb
      @breadcrumb = @category.breadcrumb
      Cache.put 'product_' + params[:id].to_s + '_breadcrumb', @breadcrumb
    end

    @categories = Cache.get 'category_' + @category.name + '_children'
    unless @categories
      @categories = @category.children
      Cache.put 'category_' + @category.name + '_children', @categories
    end
  end

  def index
    page = params[:page] || 1
    @category = params[:id]
    @categories = []
    @category = "all" if @category.nil? or @category == '' or @category == "All"

    @category = Cache.get 'category_' + @category
    unless @category
      @category = Category.find_by_name(Category.db_safe(params[:id]))
      if @category.blank?
        @category = Category.find_by_name(params[:id])
      end
      Cache.put 'category_' + @category.linkify, @category
    end

    @categories = Cache.get 'category_' + @category.linkify + '_allchildren'
    unless @categories
      @categories = @category.all_children << @category
      Cache.put 'category_' + @category.linkify + '_allchildren', @categories
    end

    @products = Cache.get 'category_' + @category.linkify + '_products_page_' + page.to_s
    unless @products
      @products = Product.paginate( { :page => page, :conditions => ['category_id in (?)', @categories], :order => 'msrp DESC', :include => :product_images})
      Cache.put 'category_' + @category.linkify + '_products_page_' + page.to_s, @products
    end

    @breadcrumb = Cache.get 'product_' + params[:id].to_s + '_breadcrumb'
    unless @breadcrumb
      @breadcrumb = @category.breadcrumb
      Cache.put 'product_' + @category.linkify + '_breadcrumb', @breadcrumb
    end
  end

end
