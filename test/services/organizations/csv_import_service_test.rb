require "test_helper"
require "csv"

module Organizations
  class CsvImportServiceTest < ActiveSupport::TestCase
    setup do
      person = create(:person)
      Current.organization = person.organization

      @file = Tempfile.new(["test", ".csv"])
      headers = ["Timestamp", "First name", "Last name", "Email", "Address", "Phone number", *Faker::Lorem.questions]

      @data = [
        Time.now,
        person.first_name,
        person.last_name,
        person.email,
        Faker::Address.full_address,
        Faker::PhoneNumber.phone_number,
        *Faker::Lorem.sentences
      ]

      CSV.open(@file.path, "wb") do |csv|
        csv << headers
      end
    end

    teardown do
      @file.unlink
    end

    should "add row information to database if person exists" do
      CSV.open(@file.path, "ab") do |csv|
        csv << @data
      end

      assert_difference "FormSubmission.count" do
        assert_difference("FormAnswer.count", + 7) do
          Organizations::Importers::GoogleCsvImportService.new(@file).call
        end
      end
    end

    should "skip row if person with email does not exist" do
      @data[3] = "email@skip.com"
      CSV.open(@file.path, "ab") do |csv|
        csv << @data
      end

      assert_no_difference "FormSubmission.count" do
        Organizations::Importers::GoogleCsvImportService.new(@file).call
      end
    end

    should "skip if row is already in database" do
      CSV.open(@file.path, "ab") do |csv|
        csv << @data
        csv << @data
      end
      assert_difference "FormSubmission.count" do
        Organizations::Importers::GoogleCsvImportService.new(@file).call
      end
    end
  end
end
