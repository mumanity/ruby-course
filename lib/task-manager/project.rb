require 'pry'
class TM::Project
  attr_reader :name, :id, :complete

  def initialize(id, name)
    @name = name
    @id = id
    @completed = []
    @incomplete = []
  end

  def self.list_projects
    @@projects
  end

  def self.add_task(task_id)
    task_id = self.id
  end

  def complete
    @tasks.each do |task|
        task.complete
    end
  end

  def completed_tasks
    @tasks.each do |task|
      if task.completed == true
        @completed << task
      end
    end

    @completed.sort_by! do |task|
      task.creation_date
    end
    @completed
  end


  def completed_tasks_by_priority
    @tasks.each do |task|
      if task.completed == true
        @completed << task
      end
    end

    @completed.sort_by! do |task|
      task.creation_date
    end
    @completed.sort_by! do |task|
      task.priority_number
    end
    @completed
  end

  def incomplete_tasks
    @tasks.each do |task|
      if task.completed == false
        @incomplete << task
      end
    end

    @incomplete.sort_by! do |task|
      task.creation_date
    end
    @incomplete
  end

  def self.reset_class_variables
    @@id_count = 0
    @@projects = []
  end
end











