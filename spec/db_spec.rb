require 'spec_helper'

describe 'DataBase' do
  it "exists" do
    expect(TM::DataBase).to be_a(Class)
  end

  it 'can create a new project with a name and unique id' do
    db = TM.db
    this = db.create_project({:name => 'first', :id => 0})
    that = db.create_project({:name => 'second', :id => 0})

    expect(this.name).to eq('first')
    expect(this.id).to eq(1)
    expect(db.projects[1]).to eq({:name => 'first', :id => 1})

    expect(that.name).to eq('second')
    expect(that.id).to eq(2)
    expect(db.projects[2]).to eq({:name => 'second', :id => 2})
  end

  it 'can call a project by id' do
    db = TM.db
    thing = db.create_project({:name => 'third', :id => 0})

    expect(db.get_project(3)).to eq({:name => 'third', :id => 3})
  end

  it 'can delete a project by id' do
    db = TM.db
    temp = db.create_project({:name => 'sadness', :id => 0})

    expect(temp.id).to eq(4)

    db.destroy_project(4)

    expect(db.projects[4]).to eq(nil)
    expect(db.projects).to eq(
    {1=>{:name=>"first", :id=>1},
      2=>{:name=>"second", :id=>2},
      3=>{:name=>"third", :id=>3}})
  end

  it 'can update a project' do
    db = TM.db
    db.update_project(2, {:name => '2s new name', :id => 2})

    expect(db.projects[2]).to eq({:name => '2s new name', :id => 2})
  end

  it 'can add a task to a project' do
    db = TM.db
    db.create_project({:name => 'for grab', :id => 0})
    2.add_task({:description => 'blah blah blah', :priority_number => 1})

    expect(db.get_tasks_for_project(1)).to eq({:description => 'blah blah blah', :priority_number => 1})
  end

  xit 'can get tasks associated with a project' do
    db = TM.db

    db.create_project({:name => 'for grab', :id => 0})
    2.add_task({:description => 'blah blah blah', :priority_number => 1})
    1.add_task({:description => 'stuff', :priority_number => 1})
    2.add_task({:description => 'chatty chat chat', :priority_number => 1})
    1.add_task({:description => 'om nom', :priority_number => 1})
    1.add_task({:description => 'blherg', :priority_number => 1})

    expect(db.get_tasks_for_project(1)).to eq(true)

    # {{:description => 'stuff', :priority_number => 1}, {:description => 'om nom', :priority_number => 1}, {:description => 'blherg', :priority_number => 1}}

    # expect(db.get_tasks_for_project(2)).to eq({{:description => 'blah blah blah', :priority_number => 1}, {:description => 'chatty chat chat', :priority_number => 1}})
  end

  xit 'can build a project' do
    db = TM.db
    moar = db.build_project({:name => 'MOAR', :id => 0})

    expect(db.projects(5)).to eq({:name => 'MOAR', :id => 5})
  end

end
