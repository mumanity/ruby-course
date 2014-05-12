
class TM::Task
  attr_accessor :description, :priority_number, :project_id, :task_id, :complete, :completed, :creation_date

# attrs is a hash with description & priority_number
  def initialize(attrs)
    @task_id = 0
    @description = attrs[:description]
    @priority_number = attrs[:priority_number]
    @completed = false
    @creation_date = Time.now
    @project_id = 0
  end

  def complete
    @completed = true
  end

  def self.reset_class_variables
    @@id_count = 0
  end
end

