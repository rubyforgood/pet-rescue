require "csv"

module Organizations
  module Importers
    class GoogleCsvImportService
      def initialize(file)
        @file = file
        @organization = Current.organization
      end

      def call
        CSV.foreach(@file.to_path, headers: true, skip_blanks: true) do |row|
          # Using Google Form headers
          email = row["Email"].downcase
          csv_timestamp = Time.parse(row["Timestamp"])

          person = Person.find_by(email:, organization: @organization)
          latest_form_submission = person.latest_form_submission

          if latest_form_submission.form_answers.empty?
            ActiveRecord::Base.transaction do
              form_submission = latest_form_submission
              row.each do |col|
                next if col[0] == "Email" || col[0] == "Timestamp"

                FormAnswer.create!(form_submission:,
                  question_snapshot: col[0], value: col[1])
              end
            end
          else
            existing_submission = FormSubmission.find_by(person:, csv_timestamp:)

            next if existing_submission

            ActiveRecord::Base.transaction do
              form_submission = FormSubmission.create!(person:, csv_timestamp:)
              row.each do |col|
                next if col[0] == "Email" || col[0] == "Timestamp"

                FormAnswer.create!(form_submission:,
                  question_snapshot: col[0], value: col[1])
              end
            end
          end
        end
      end
    end
  end
end
