class Task
  attr_reader :id
  attr_accessor :title, :description, :done

  def initialize(attributes = {})
    @id = attributes[:id]
    @title = attributes[:title]
    @description = attributes[:description]
    @done = attributes[:done] || false
  end

  def save
    if @id.nil?
      query = 'INSERT INTO tasks (title, description, done) VALUES (?, ?, ?)'
      DB.execute(query, [@title, @description, fancy_boolean_converter(@done)])
      @id = DB.last_insert_row_id
    else
      query = 'UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?'
      DB.execute(query, @title, @description, fancy_boolean_converter(@done), @id)
    end
  end

  def destroy
    query = 'DELETE FROM tasks WHERE id = ?'
    DB.execute(query, @id)
  end

  def self.find(id)
    query = 'SELECT * FROM tasks WHERE id = ?'
    row = DB.execute(query, [id]).first
    unless row.nil?
      build_task(row)
    end
  end

  def self.all
    query = 'SELECT * FROM tasks'
    rows = DB.execute(query)
    rows.map do |row|
      build_task(row)
    end
  end

  def fancy_boolean_converter(boolean)
    boolean ? 1 : 0
  end

  def self.build_task(row)
    Task.new(id: row['id'],
             title: row['title'],
             description: row['description'],
             done: row['done'] == 1)
  end
end
