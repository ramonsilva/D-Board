require 'spec_helper'

describe TasksController do

  let(:story) { stub_model(Story, id: 42, name: 'Some Story name') } 
  let(:params) { { story_id: story.id } }
  let(:valid_attributes) { { "description" => "MyText", status: 1, story_id: story.id } }
  let(:valid_session) { {} }

  before :each do
    Story.stub(:find).and_return(story)
  end

  shared_examples "finding story" do |method| 
    it "assigns a story from params as @story" do
      get method, params
      assigns(:story).should == story
    end
  end

  describe "GET new" do
    it_behaves_like "finding story", :new

    it "assigns a new task as @task" do
      get :new, params
      assigns(:task).should be_a_new(Task)
    end

    it "@task should belongs to @story" do
      get :new, params
      assigns(:task).story_id.should == story.id
    end
  end

  describe "GET edit" do
    let(:task) { Task.create! valid_attributes }

    before :each do
      params.merge!(id: task.id)
    end

    it_behaves_like "finding story", :edit

    it "assigns the requested task as @task" do
      get :edit, params, valid_session
      assigns(:task).should eq(task)
    end

    it "find @task by story" do
      story.tasks.should_receive(:find).and_return(task) 
      get :edit, params, valid_session
    end
  end

  describe "POST create" do

    it_behaves_like "finding story", :create

    describe "with valid params" do
      before :each do
        valid_attributes.delete(:status)
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

      it "newly created task status must be TODO" do
        post :create, params, valid_session
        assigns(:task).status.should == 1
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
      let(:task) { Task.create! valid_attributes }

      before :each do
        params.merge!(id: task.id, task: valid_attributes) 
      end

      it_behaves_like "finding story", :update

      it "updates the requested task" do
        # Assuming there are no other tasks in the database, this
        # specifies that the Task created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        attributes_to_update = { "description" => "MyText" }
        Task.any_instance.should_receive(:update_attributes).with(attributes_to_update)
        params.merge!(task: attributes_to_update)
        put :update, params, valid_session
      end

      it "assigns the requested task as @task" do
        put :update, params, valid_session
        assigns(:task).should eq(task)
      end

      it "redirects to the story list" do
        task = Task.create! valid_attributes
        put :update, params, valid_session
        response.should redirect_to(stories_url)
      end
    end

    describe "with invalid params" do
      let!(:task) do
        task = Task.create! valid_attributes
        params.merge!(id: task.id, task: {description: 'invalid value'})
        task
      end
      it "assigns the task as @task" do
        # Trigger the behavior that occurs when invalid params are submitted
        Task.any_instance.stub(:save).and_return(false)
        put :update, params, valid_session
        assigns(:task).should eq(task)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Task.any_instance.stub(:save).and_return(false)
        put :update, params, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it_behaves_like "finding story", :destroy

    before :each do
      task = Task.create! valid_attributes
      params.merge!(id: task.to_param) 
    end

    it "destroys the requested task" do
      expect {
        delete :destroy, params, valid_session
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the story list" do
      delete :destroy, params, valid_session
      response.should redirect_to(stories_url)
    end
  end

end
