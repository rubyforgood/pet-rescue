class AddStatusToMatches < ActiveRecord::Migration[6.0]
  def up
    safety_assured do
      add_column :matches, :status, :integer

      execute <<-SQL
        CREATE OR REPLACE FUNCTION update_match_status()
        RETURNS TRIGGER AS $$
        BEGIN
          IF NEW.start_date IS NULL OR NEW.end_date IS NULL THEN
            NEW.status := 0; -- Not applicable
          ELSIF NOW() > NEW.end_date THEN
            NEW.status := 3; -- Completed
          ELSIF NOW() < NEW.start_date THEN
            NEW.status := 2; -- Upcoming
          ELSE
            NEW.status := 1; -- Current
          END IF;
          RETURN NEW;
        END;
        $$ LANGUAGE plpgsql;
      SQL

      # Create the trigger that fires before each insert or update
      execute <<-SQL
        CREATE OR REPLACE TRIGGER set_match_status
        BEFORE INSERT OR UPDATE ON matches
        FOR EACH ROW EXECUTE FUNCTION update_match_status();
      SQL

      # Update the status for existing rows
      execute <<-SQL
        UPDATE matches
        SET status = CASE
          WHEN start_date IS NULL OR end_date IS NULL THEN 0 -- Not applicable
          WHEN end_date < NOW() THEN 3 -- Completed
          WHEN start_date > NOW() THEN 2 -- Upcoming
          ELSE 1 -- Current
        END;
      SQL
    end
  end

  def down
    safety_assured do
      # Drop the trigger
      execute <<-SQL
        DROP TRIGGER IF EXISTS set_match_status ON matches;
      SQL

      # Drop the function
      execute <<-SQL
        DROP FUNCTION IF EXISTS update_match_status();
      SQL

      # Remove the status column
      remove_column :matches, :status
    end
  end
end
