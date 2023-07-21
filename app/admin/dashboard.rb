# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Quick Stats" do
          ul do
            li do 
              "# Staff Accounts: #{StaffAccount.all.count} accounts"
            end
            li do 
              "# Adopter Accounts: #{AdopterAccount.all.count} accounts"
            end
            li do
              "# Unadopted Dogs: #{Dog.where.missing(:adoption).count}"
            end
            li do
              "# Adoptions: #{Adoption.all.count}"
            end
          end
        end
        panel "Donations" do
          ul do
            li do
              "# Donations: #{Donation.all.count}"
            end
            Donation.sum_donations_by_currency.each do |k,v|
              li do 
                "#{k}: $#{v}"
              end
            end
          end
        end
        # Chartkick charts here
        panel "Adoptions Over Time" do
          line_chart Adoption.all.group_by { |adp| adp.created_at.beginning_of_month }
                                 .map { |date, adps| [date, adps.count] }.to_h
        end

        panel "Donations Over Time" do
          line_chart Donation.all.group_by { |donation| donation.created_at.beginning_of_month }
                                 .map { |date, donations| [date, donations.sum { |donation| donation.amount.to_f }] }.to_h
        end

        panel "User Sign Ups Over Time" do
          line_chart User.all.group_by { |user| user.created_at.beginning_of_month }
                             .map { |date, users| [date, users.count] }.to_h
        end
      end
    end
  end
end
