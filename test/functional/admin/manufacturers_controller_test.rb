require 'test_helper'

class Admin::ManufacturersControllerTest < ActionController::TestCase
  setup do
    @admin_manufacturer = admin_manufacturers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_manufacturers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_manufacturer" do
    assert_difference('Admin::Manufacturer.count') do
      post :create, admin_manufacturer: { name: @admin_manufacturer.name, url: @admin_manufacturer.url }
    end

    assert_redirected_to admin_manufacturer_path(assigns(:admin_manufacturer))
  end

  test "should show admin_manufacturer" do
    get :show, id: @admin_manufacturer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_manufacturer
    assert_response :success
  end

  test "should update admin_manufacturer" do
    put :update, id: @admin_manufacturer, admin_manufacturer: { name: @admin_manufacturer.name, url: @admin_manufacturer.url }
    assert_redirected_to admin_manufacturer_path(assigns(:admin_manufacturer))
  end

  test "should destroy admin_manufacturer" do
    assert_difference('Admin::Manufacturer.count', -1) do
      delete :destroy, id: @admin_manufacturer
    end

    assert_redirected_to admin_manufacturers_path
  end
end
