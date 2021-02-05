require "sqlite3"
DB = SQLite3::Database.new("tasks.db")

DB.execute('DROP TABLE IF EXISTS tasks;')
DB.execute(<<-SQL
CREATE TABLE tasks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT,
  description TEXT,
  done INTEGER DEFAULT (0)
)
SQL
)
DB.execute(<<-SQL
INSERT INTO tasks
  (title, description)
  VALUES
  ('Complete Livecode', 'Implement CRUD on Task');
SQL
)
