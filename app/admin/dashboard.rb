# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Adopter Accounts" do
          para do 
            "Total: #{AdopterAccount.all.count} accounts"
            end
          end
        end
      end

    columns do
      column do
        panel "Unadopted Dogs" do
          para do 
            "Total: #{Dog.where.missing(:adoption).count} dogs."
            end
          end
        end
      end
    
    columns do
      column do
        panel "Adopted Dogs" do
          para do 
            "Total: #{Dog.includes(:adoption).where.not(adoption: { id: nil }).count} dogs."
            end
          end
        end
      end
  end
end
