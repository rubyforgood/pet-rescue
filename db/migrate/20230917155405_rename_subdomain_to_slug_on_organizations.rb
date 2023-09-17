class RenameSubdomainToSlugOnOrganizations < ActiveRecord::Migration[7.0]
  def change
    safety_assured { rename_column :organizations, :subdomain, :slug }
  end
end
