require 'spec_helper'

describe "Tasks" do
  describe "GET /tasks" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get story_tasks_path 1
      response.status.should be(200)
    end
  end
end
