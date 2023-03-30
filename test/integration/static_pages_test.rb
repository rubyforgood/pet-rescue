require "test_helper"

class StaticPagesTest < ActionDispatch::IntegrationTest

  test "Home page can be accessed" do
    get '/'
    assert_response :success
    assert_select 'h1', 'We rescue dogs in Baja, Mexico and rehome them with adopters in 
      Canada and America'
  end

  test "Account select can be accessed" do
    get '/account_select'
    assert_response :success
    assert_select 'h1', 'Sign Up'
  end
  
  test "About Us page can be accessed" do
    get '/about_us'
    assert_response :success
    assert_select 'h1', 'About us'
  end

  test "FAQ page can be accessed" do
    get '/faq'
    assert_response :success
    assert_select 'h1', 'Frequently Asked Questions'
  end

  test "Partners page can be accessed" do
    get '/partners'
    assert_response :success
    assert_select 'h1', 'Partners'
  end

  test "Donate page can be accessed" do
    get '/donate'
    assert_response :success
    assert_select 'h1', 'Donate'
  end

  test "Contact Us page can be accessed" do
    get '/contacts/new'
    assert_response :success
    assert_select 'h1', 'Contact Us'
  end

  test "Privacy Policy page can be accessed" do
    get '/privacy_policy'
    assert_response :success
    assert_select 'h1', 'Privacy Policy'
  end

  test "Terms and Conditions page can be accessed" do
    get '/terms_and_conditions'
    assert_response :success
    assert_select 'h1', 'Terms and Conditions'
  end

  test "Cookie Policy page can be accessed" do
    get '/cookie_policy'
    assert_response :success
    assert_select 'h1', 'Cookie Policy'
  end

  test "successes page can be accessed" do
    get "/successes"
    assert_response :success
    assert_select 'h1', 'Successes'
  end

end
