require "test_helper"

class AdopterProfileTest < ActionDispatch::IntegrationTest

  adopter_account_id = User.find_by(email: 'test@test123.com').adopter_account.id

  setup do
    sign_in users(:user_four)
  end

  test "All 24 errors and their custom messages appear on blank form submission" do
    post '/adopter_profile',
    params: { adopter_profile: 
      {
        adopter_account_id: adopter_account_id,
        phone_number: '',
        contact_method: '',
        country: '',
        province_state: '',
        city_town: '',
        ideal_dog: '',
        lifestyle_fit: '',
        activities: '',
        alone_weekday: '',
        alone_weekend: '',
        experience: '',
        contingency_plan: '',
        shared_owner: '',
        housing_type: '',
        fenced_alternative: '',
        location_day: '',
        location_night: '',
        adults_in_home: '',
        kids_in_home: '',
        describe_pets: '',
        describe_surrender: '',
        annual_cost: ''
      },
      commit: 'Save profile'
    }

    assert_select 'div.alert', { count: 25 }
    assert_select 'div.alert' do 
    assert_select 'p', 'Please fix 24 
        errors highlighted below.'
    end
    assert_select 'div.alert', 'Phone number is invalid'
    assert_select 'div.alert', "Contact method can't be blank"
    assert_select 'div.alert', "Country can't be blank"
    assert_select 'div.alert', "Please select a province or state"
    assert_select 'div.alert', "Please enter your city or town"
    assert_select 'div.alert', "Please tell us about your ideal dog"
    assert_select 'div.alert', "Please tell us about your lifestyle"
    assert_select 'div.alert', "Please tell us about the activities"
    assert_select 'div.alert', "This field cannot be blank", { count: 2}
    assert_select 'div.alert', "Please tell us about your dog experience"
    assert_select 'div.alert', "Please tell us about your contingencies"
    assert_select 'div.alert', "Select one", { count: 6 }
    assert_select 'div.alert', "Housing type can't be blank"
    assert_select 'div.alert', "can't be blank", { count: 2 }
    assert_select 'div.alert', "Adults in home can't be blank"
    assert_select 'div.alert', "Kids in home can't be blank"
    assert_select 'div.alert', "Please provide an annual cost estimate"
  end

end