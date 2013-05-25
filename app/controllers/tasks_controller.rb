class TasksController < ApplicationController
  before_filter :find_story, :except  => :update

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = @story.tasks.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = @story.tasks.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @story.tasks.build(params[:task])
    @task.status = 1

    respond_to do |format|
      if @task.save
        format.html { redirect_to stories_path, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to stories_path, notice: 'Task was successfully updated.' }
        format.json { render json: {status:'ok'} }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to stories_path }
      format.json { head :no_content }
    end
  end

  private

  def find_story
    @story = Story.find(params[:story_id])
  end
end
