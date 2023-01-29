ActiveAdmin.register StaffAccount do
  permit_params :organization_id, :verified, :user_id  
end
