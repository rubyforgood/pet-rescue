crumb :root do
  link "Home", dashboard_index_path
end

crumb :dashboard_pets do
  link "Pets", pets_path
end

crumb :dashboard_pet do |pet|
  link pet.name, pet_path(pet)
  parent :dashboard_pets
end

crumb :organization_profile do |organization|
  link "Edit Profile", edit_organization_profile_path(organization)
end

crumb :staff_index do
  link "Staff", staff_index_path
end

crumb :default_pet_tasks_index do
  link "Default Pet Tasks", default_pet_tasks_path
end

crumb :forms_index do
  link "Forms", forms_path
end

crumb :form do |form|
  link form.name, form_path(form)
  parent :forms_index
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
