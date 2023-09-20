def log_seed_output(msg)
  puts "[ Seeding ] #{msg}\n"
end

if Rails.env.production?
  log_seed_output "Seed cannot run in production"
  log_seed_output "Exiting"
  return
end

ActiveRecord::Base.transaction do
  a = Time.now
  log_seed_output "-----------------------"
  log_seed_output "🌱 Seed Process started"
  log_seed_output "-----------------------"

  puts "\n\n"

  Dir[Rails.root.join("db", "seeds", "*.rb")].sort.each do |seed|
    # Print out file name
    puts "[ Seeding ] #{seed} started"
    load seed
    puts "[ Seeding ] #{seed} completed"
  end

  puts "\n\n"
  log_seed_output "-----------------------"
  log_seed_output "🌱 Seed Process ended in #{Time.now - a} seconds"
  log_seed_output "-----------------------"
end
