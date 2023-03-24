require "test_helper"

class SuccessesPageTest < ActionDispatch::IntegrationTest

  # setup do
  # end

  test "A list element for each adopted dog with lat lon data attributes is created" do
    get '/successes'
    assert_select 'ul.coordinates' do
      assert_select 'li', { count: Adoption.all.count }
      assert_select 'li[data-lat]', { value: "51.0866897" }
      assert_select 'li[data-lon]', { value: "-115.3481135" }
    end

  end

  # make an adoption and test one more list
  # changes lat/lon and test changed lat lon

end
