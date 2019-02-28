class Student
  attr_reader :id
  attr_accessor :name, :grade

  def initialize (name, grade)
    self.name = name
    self.grade = grade
  end

  def self.create_table
    DB[:conn].execute("CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, grade INTEGER);")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students;")
  end

  def save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?,?);",[self.name, self.grade])
    @id = DB[:conn].last_insert_row_id
  end

  def self.create (name:, grade:)
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?,?);",[name, grade])
    Student.new(name, grade)
  end
end
