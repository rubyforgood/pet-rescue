require "test_helper"
require "csv"

class Organizations::CsvImportServiceTest < ActiveSupport::TestCase
  setup do
    headers = ["Timestamp", "Name", "Email", "Address", "Phone number", * Faker::Lorem.questions]
    @file_path = Rails.root.join("tmp", "test.csv")
    @file = CSV.open(@file_path, "wb") do |csv|
      csv << headers
    end
    @person = create(:person)
    Current.organization = @person.organization
  end

  should "add row information to database if person exists" do
    CSV.open(@file_path, "ab") do |csv|
      csv << [
        Time.now,
        @person.name,
        @person.email,
        Faker::Address.full_address,
        Faker::PhoneNumber.phone_number,
        *Faker::Lorem.sentences
      ]
    end

    assert_difference "FormSubmission.count" do
      assert_difference("FormAnswer.count", + 6) do
        Organizations::CsvImportService.new(File.open(@file_path)).call
      end
    end
  end

  should "skip row if person with email does not exist" do
    CSV.open(@file_path, "ab") do |csv|
      csv << [
        Time.now,
        @person.name,
        "skip@email.com",
        Faker::Address.full_address,
        Faker::PhoneNumber.phone_number,
        *Faker::Lorem.sentences
      ]
    end

    assert_no_difference "FormSubmission.count" do
      Organizations::CsvImportService.new(File.open(@file_path)).call
    end
  end

  # should "skip if row is already in database" do
  #   data = [
  #     Time.now,
  #     @person.name,
  #     @person.email,
  #     Faker::Address.full_address,
  #     Faker::PhoneNumber.phone_number,
  #     *Faker::Lorem.sentences
  #   ]
  #   CSV.open(@file_path, "ab") do |csv|
  #     csv << data
  #     csv << data
  #   end
  #   assert_difference "FormSubmission.count" do
  #     Organizations::CsvImportService.new(File.open(@file_path)).call
  #   end
  # end
end
