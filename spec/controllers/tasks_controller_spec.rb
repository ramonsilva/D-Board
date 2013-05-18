require 'spec_helper'

describe TasksController do

  let(:valid_attributes) { { "description" => "MyText", status: 1 } }
  let(:valid_session) { {} }
  let(:story) { stub_model(Story, id: 42, name: 'Some Story name') } 
  let(:params) { { story_id: story.id } }

  shared_examples "finding story" do |method| 
    it "assigns a story from params as @story" do
      get method, params
      assigns(:story).should == story
    end
  end

  describe "GET new" do
    before :each do
      Story.stub(:find).and_return(story)
    end

    it "assigns a story from params as @story" do
      get :new, params
      assigns(:story).should == story
    end
    it "assigns a new task as @task" do
      get :new, params
      assigns(:task).should be_a_new(Task)
    end
  end

  describe "GET edit" do
    let(:task) { Task.create! valid_attributes }
    before :each do
      Story.stub(:find).and_return(story)
      params.merge!(id: task.id)
    end

    it_behaves_like "finding story", :edit

    it "assigns the requested task as @task" do
      get :edit, params, valid_session
      assigns(:task).should eq(task)
    end
  end

  describe "POST create" do
    let(:params) { { story_id: story.id} }

    before :each do
      Story.stub(:find).and_return(story)
    end

    describe "with valid params" do
      before :each do
        params.merge!(task: valid_attributes)
      end

      it "creates a new Task" do
        expect {
          post :create, params, valid_session
        }.to change(Task, :count).by(1)
      end

      it "assigns a newly created task as @task" do
        post :create, params, valid_session
        assigns(:task).should be_a(Task)
        assigns(:task).should be_persisted
      end

      it "redirects to the story board" do
        post :create, params, valid_session
        response.should redirect_to(stories_path)
      end
    end

    describe "with invalid params" do
      before :each do
        params.merge!(task: {description: 'invalid values'})
      end
      it "assigns a newly created but unsaved task as @task" do
        # Trigger the behavior that occurs when invalid params are submitted
        Task.any_instance.stub(:save).and_return(false)
        post :create, params
        assigns(:task).should be_a_new(Task)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Task.any_instance.stub(:save).and_return(false)
        post :create, params, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested task" do
        task = Task.create! valid_attributes
        # Assuming there are no other tasks in the database, this
        # specifies that the Task created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Task.any_instance.should_receive(:update_attributes).with({ "description" => "MyText" })
        put :update, {:id => task.to_param, :task => { "description" => "MyText" }}, valid_session
      end

      it "assigns the requested task as @task" do
        task = Task.create! valid_attributes
        put :update, {:id => task.to_param, :task => valid_attributes}, valid_session
        assigns(:task).should eq(task)
      end

      it "redirects to the task" do
        task = Task.create! valid_attributes
        put :update, {:id => task.to_param, :task => valid_attributes}, valid_session
        response.should redirect_to(task)
      end
    end

    describe "with invalid params" do
      it "assigns the task as @task" do
        task = Task.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Task.any_instance.stub(:save).and_return(false)
        put :update, {:id => task.to_param, :task => { "description" => "invalid value" }}, valid_session
        assigns(:task).should eq(task)
      end

      it "re-renders the 'edit' template" do
        task = Task.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Task.any_instance.stub(:save).and_return(false)
        put :update, {:id => task.to_param, :task => { "description" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete :destroy, {:id => task.to_param}, valid_session
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      task = Task.create! valid_attributes
      delete :destroy, {:id => task.to_param}, valid_session
      response.should redirect_to(tasks_url)
    end
  end

end
