class Admin::CategoriesController < ApplicationController
  
  before_filter :login_required, :admin_login_required

  def new_sub
    @parent_id = params[:id]
    @category = Category.new
    @breadcrumbs = @category.breadcrumb
    render :action => 'new'
  end

  def create 
    @category = Category.new(params[:category])
    if @category.save
      redirect_to edit_admin_category_path( @category )
    else
      redirect_to :action => 'new_sub', :id => params[:id]
    end
  end

  # GET /admin/categories
  def index
    @category = Category.find(:first, :conditions => { :name => 'all' } )
    redirect_to edit_admin_category_path(@category)
  end

  # GET /admin/categories/1/edit
  def edit
    @category = Category.find(params[:id])
    @breadcrumbs = @category.breadcrumb
    @sub_categories = Category.find(:all, :conditions => { :parent_id => @category.id } ) 
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to edit_admin_category_path(@category)
    end
  end
end
