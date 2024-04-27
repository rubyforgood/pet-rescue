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

crumb :page_text do |page_text|
  link "Edit Page Text", edit_page_text_path(page_text)
end

crumb :staff_index do
  link "Staff", staff_index_path
end

crumb :default_pet_tasks_index do
  link "Default Pet Tasks", default_pet_tasks_path
end

crumb :faqs_index do
  link "FAQs", faqs_path
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
