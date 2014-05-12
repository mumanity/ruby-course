require 'pry'

module TM
  class TM::DataBase
    attr_reader :tasks, :projects

    def initialize
      @projects = {}
      @tasks = {}
      @project_count = 0
    end

# attrs is a hash
    def create_project(attrs)
      @project_count += 1

      attrs[:id] = @project_count
      @projects[attrs[:id]] = attrs

      Project.new(attrs[:id], attrs[:name])
    end

    def get_project(id)
      @projects[id]
    end

    def destroy_project(id)
      @projects.delete(id)
    end

    def update_project(id, data)
      @projects[id] = data
    end

    def build_project(data)
      Project.new(data[:name], data[:id])
    end

    def get_tasks_for_project(pid)
      @tasks.select {|task| task.project_id == pid}
    end

  end

    def self.db
      @__db_instance ||= DataBase.new
    end
end
