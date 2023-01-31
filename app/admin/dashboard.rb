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
      end
    end
  end
end
