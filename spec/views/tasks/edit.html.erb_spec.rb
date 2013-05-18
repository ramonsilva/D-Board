require 'spec_helper'

describe "tasks/edit" do
  before(:each) do
    @story = assign :story, stub_model(Story, id: 42, name: 'Story Name') 
    @task  = assign :task, stub_model(Task,
      :description => "MyText",
      :status => 1,
      :story => @story
    )
  end

  it "renders the edit task form" do
    render
    assert_select "form[action=?][method=?]", story_task_path(@story, @task), "post" do
      assert_select "textarea#task_description[name=?]", "task[description]"
    end
  end
end
