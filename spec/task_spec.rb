require 'spec_helper'

describe 'Task' do
  before(:each) do
    TM::Task.reset_class_variables
    @t1 = TM::Task.new('learning things', 1)
    @t2 = TM::Task.new('learning moar things', 2)
    @t3 = TM::Task.new('learning moar things', 3)
  end

  xit "exists" do
    expect(TM::Task).to be_a(Class)
  end

  xit 'can be created with a description, and priority number' do
    expect(@t1.task_id).to eq(1)
    expect(@t1.description).to eq('learning things')
    expect(@t1.priority_number).to eq(1)

    expect(@t2.task_id).to eq(2)
    expect(@t2.description).to eq('learning moar things')
    expect(@t2.priority_number).to eq(2)
  end

  xit 'can be marked as complete' do

    expect(@t1.complete).to eq(true)
    expect(@t2.complete).to eq(true)
    expect(@t3.complete).to eq(true)
  end

end


