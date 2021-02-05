require "sqlite3"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
require_relative "task"

# TODO: CRUD some tasks

# 1. Implement the READ logic to find a given task (by its id)
task = Task.find(1)
puts "#{task.title} - #{task.description}"

# 2. Implement the CREATE logic in a save instance method
new_task = Task.new(title: 'Kick back',
                    description: 'Relax after a challenging week')
new_task.save
puts "The new tasks's id is: #{new_task.id}"

# 3. Implement the UPDATE logic in the same method
new_task.description = 'Relax after an enjoyable week!'
# new_task.mark_as_done
new_task.save
new_task = Task.find(new_task.id)
puts "New description: #{new_task.description}"

# 4. Implement the READ logic to retrieve all tasks (what type of method is it?)
tasks = Task.all
tasks.each do |task|
  done = task.done ? 'x' : ' '
  puts "#{task.id} - [#{done}] #{task.title} - #{task.description}"
end

# 5. DESTROY logic
task = Task.find(1)
task.destroy
task = Task.find(1)
puts "Does the task exist? #{!task.nil?}"
