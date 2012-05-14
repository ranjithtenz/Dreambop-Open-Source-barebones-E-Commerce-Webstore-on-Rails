class Admin::ManufacturersController < ApplicationController
  before_filter :login_required, :admin_login_required


  # GET /admin/manufacturers
  # GET /admin/manufacturers.json
  def index
    @manufacturers = Manufacturer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @manufacturers }
    end
  end

  # GET /admin/manufacturers/1
  # GET /admin/manufacturers/1.json
  def show
    @manufacturer = Manufacturer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @manufacturer }
    end
  end

  # GET /admin/manufacturers/new
  # GET /admin/manufacturers/new.json
  def new
    @manufacturer = Manufacturer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_manufacturer }
    end
  end

  # GET /admin/manufacturers/1/edit
  def edit
    @manufacturer = Manufacturer.find(params[:id])
  end

  # POST /admin/manufacturers
  # POST /admin/manufacturers.json
  def create
    @manufacturer = Manufacturer.new(params[:manufacturer])

    respond_to do |format|
      if @manufacturer.save
        format.html { redirect_to admin_manufacturer_path(@manufacturer), notice: 'Manufacturer was successfully created.' }
        format.json { render json: @manufacturer, status: :created, location: @manufacturer }
      else
        format.html { render action: "new" }
        format.json { render json: @manufacturer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/manufacturers/1
  # PUT /admin/manufacturers/1.json
  def update
    @manufacturer = Manufacturer.find(params[:id])

    respond_to do |format|
      if @manufacturer.update_attributes(params[:manufacturer])
        format.html { redirect_to admin_manufacturer_path(@manufacturer), notice: 'Manufacturer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @manufacturer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/manufacturers/1
  # DELETE /admin/manufacturers/1.json
  def destroy
    @manufacturer = Manufacturer.find(params[:id])
    @manufacturer.destroy

    respond_to do |format|
      format.html { redirect_to admin_manufacturers_url }
      format.json { head :no_content }
    end
  end
end
