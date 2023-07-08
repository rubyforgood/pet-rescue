require "test_helper"

class SuccessesPageTest < ActionDispatch::IntegrationTest

  setup do 
    @adopter_account = adopter_accounts(:adopter_account_one)
    @dog = dogs(:one)
    @adoptions = Adoption.all
  end

  test "location lat and lon are deviated by google maps data builder" do
    get '/successes'
    assert_response :success

    list_element = css_select('li[data-lat]').first
    lat_value = list_element['data-lat'].to_f
    list_element = css_select('li[data-lon]').first
    lon_value = list_element['data-lon'].to_f
    name_value = list_element['data-name']
    breed_value = list_element['data-breed']

    assert_not_equal(lat_value, locations(:locations_one).latitude)
    assert_not_equal(lon_value, locations(:locations_one).longitude)
    assert_equal(name_value, dogs(:adopted_dog).name)
    assert_equal(breed_value, dogs(:adopted_dog).breed)
  end

  test "An additional list element is created when a new adoption is made" do
    sign_in users(:verified_staff_one)
    adoption_count_before = @adoptions.count

    post '/create_adoption',
      params: { adopter_account_id: @adopter_account.id, dog_id: @dog.id }
    
    get '/successes'
    assert_select 'ul.coordinates' do
      assert_select 'li', { count: adoption_count_before + 1 }
      assert_select 'li[data-lat]', { count: adoption_count_before + 1 }
      assert_select 'li[data-lon]', { count: adoption_count_before + 1 }
    end
  end
end
