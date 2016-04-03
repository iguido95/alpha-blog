require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  def setup
    @category = Category.create(name: "sports")
    @admin_user = User.create(username: "John", email: "john@example.com", password: "password", is_admin: true)
  end

  test "should get categories index" do
    get :index
    assert_response :success
  end

  test "should get new when an admin" do
    session[:user_id] = @admin_user.id
    get :new
    assert_response :success
  end

  test "should get show" do
    get(:show, { id: @category.id })
    assert_response :success
  end

  test "should redirect when not an admin" do
    assert_no_difference 'Category.count' do
      post :create, category: { name: "sports" }
    end
    assert_redirected_to categories_path
  end

end
