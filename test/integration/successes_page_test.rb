require "test_helper"

class SuccessesPageTest < ActionDispatch::IntegrationTest

  setup do 
    @adopter_account = adopter_accounts(:adopter_account_one)
    @dog = dogs(:dog_three)
    @adoptions = Adoption.all
  end

  test "A list element for each adopted dog with lat lon data attributes is created" do
    get '/successes'
    assert_select 'ul.coordinates' do
      assert_select 'li', { count: @adoptions.count }
      assert_select 'li[data-lat]', { value: "51.0866897" }
      assert_select 'li[data-lon]', { value: "-115.3481135" }
    end
  end

  test "An additional list element is created when a new adoption is made" do
    sign_in users(:user_two)
    adoption_count_before = @adoptions.count

    post '/create_adoption',
      params: { adopter_account_id: @adopter_account.id, dog_id: @dog.id }
    
    get '/successes'
    assert_select 'ul.coordinates' do
      assert_select 'li', { count: adoption_count_before + 1 }
      assert_select 'li[data-lat]', { value: "51.0866897", count: adoption_count_before + 1 }
      assert_select 'li[data-lon]', { value: "-115.3481135", count: adoption_count_before + 1 }
    end
  end
end
