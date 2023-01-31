ActiveAdmin.register StaffAccount do
  permit_params :organization_id, :verified, :user_id

  index do
    selectable_column
    id_column
    column :created_at
    column :full_name
    column :email
    column :organization
    column :verified
    actions
  end

  form do |f|
    f.inputs do
      f.input :organization
      f.input :verified
    end
    f.actions
  end

end
