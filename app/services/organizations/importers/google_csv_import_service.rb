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
          previous = FormSubmission.where(person:, csv_timestamp:)
          next unless person && previous.empty?

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
