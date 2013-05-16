require "spec_helper"

describe TasksController do
  describe "routing" do

    it "routes to #index" do
      get("/stories/42/tasks").should route_to("tasks#index", story_id: "42")
    end

    it "routes to #new" do
      get("/stories/42/tasks/new").should route_to("tasks#new", story_id: "42")
    end

    it "routes to #show" do
      get("/stories/42/tasks/1").should route_to("tasks#show", story_id: "42", id: "1")
    end

    it "routes to #edit" do
      get("/stories/42/tasks/1/edit").should route_to("tasks#edit", story_id: "42", id: "1")
    end

    it "routes to #create" do
      post("/stories/42/tasks").should route_to("tasks#create", story_id: "42")
    end

    it "routes to #update" do
      put("/stories/42/tasks/1").should route_to("tasks#update", story_id: "42", id: "1")
    end

    it "routes to #destroy" do
      delete("/stories/42/tasks/1").should route_to("tasks#destroy", story_id: "42", id: "1")
    end

  end
end
