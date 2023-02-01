ActiveAdmin.register StaffAccount do
  permit_params :organization_id, :verified, :user_id

  # fields to display on /staff_accounts
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

  # fields to display on staff_accounts/:id/edit
  form do |f|
    f.inputs do
      f.input :organization
      f.input :verified
    end
    f.actions
  end

end
