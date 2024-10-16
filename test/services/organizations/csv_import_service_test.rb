require "test_helper"
require "csv"

module Organizations
  class CsvImportServiceTest < ActiveSupport::TestCase
    setup do
      person = create(:adopter)
      Current.organization = person.organization

      @file = Tempfile.new(["test", ".csv"])
      headers = ["Timestamp", "First name", "Last name", "Email", "Address", "Phone number", *Faker::Lorem.questions]

      @data = [
        "2024-10-02 12:45:37.000000000 +0000",
        person.first_name,
        person.last_name,
        person.email,
        Faker::Address.full_address,
        Faker::PhoneNumber.phone_number,
        *Faker::Lorem.sentences
      ]

      @person = person

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

      assert_no_difference "FormSubmission.count" do
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

    should "skip if the user exists and the timestamp matches that on the FormSubmisson" do
      CSV.open(@file.path, "ab") do |csv|
        csv << @data
      end
      @person.latest_form_submission.update(csv_timestamp: @data[0])

      assert_no_difference -> { @person.latest_form_submission.form_answers.count } do
        Organizations::Importers::GoogleCsvImportService.new(@file).call
      end
    end

    should "creates a new form submission and adds the form answers if there is no 'empty' form submission and the timestamp is different" do
      CSV.open(@file.path, "ab") do |csv|
        csv << @data
      end
      Organizations::Importers::GoogleCsvImportService.new(@file).call
      @person.latest_form_submission.update(csv_timestamp: "2024-10-03 12:45:37.000000000 +0000")

      assert_difference -> { @person.person.form_submissions.count } do
        assert_difference -> { @person.person.form_answers.count }, 7 do
          Organizations::Importers::GoogleCsvImportService.new(@file).call
        end
      end
    end
  end
end
