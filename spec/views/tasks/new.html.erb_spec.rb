require 'spec_helper'

describe "tasks/new" do
  before(:each) do
    @story = assign(:story, stub_model(Story, id: 42, name: "Story Name"))
    @task = assign(:task, stub_model(Task,
      :description => "MyText",
      :status => "",
      :story => @story
    ).as_new_record)
  end

  it "renders new task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", story_tasks_path(@story), "post" do
      assert_select "textarea#task_description[name=?]", "task[description]"
    end
  end
end
