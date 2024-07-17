should "count the total number of applications" do
  get staff_dashboard_index_url
  assert_equal 2, assigns(:application_count)
end

should "return zero when the total number of adopter applications is nil" do
  user2 = create(:staff)

  sign_in user2
  get staff_dashboard_index_url
  assert_equal 0, assigns(:application_count)
end
