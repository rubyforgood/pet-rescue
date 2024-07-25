require "csv"

module Organizations
  class CsvImportService
    def initialize(file)
      @file = file
      @organization = Current.organization
    end

    def call
      CSV.foreach(@file.to_path, headers: true, skip_blanks: true) do |row|
        # Using Google Form headers
        email = row["Email"]
        timestamp = Time.parse(row["Timestamp"])

        # Check for matching person in organization
        person = Person.find_by(email:, organization: @organization)
        next unless person

        # Skip rows that have already been imported
        # previous = FormSubmission.where(person: person, csv_timestamp: timestamp)
        # next unless previous.empty?

        ActiveRecord::Base.transaction do
          form_submission = FormSubmission.create!(person:) # , csv_timestamp: timestamp
          row.each do |col|
            # skip Email and Timestamp col as they are saved on Form Submission
            next if col[0] == "Email" || col[0] == "Timestamp"

            FormAnswer.create!(form_submission:,
              question_snapshot: col[0], value: col[1])
          end
        end
      end
    end
  end
end
