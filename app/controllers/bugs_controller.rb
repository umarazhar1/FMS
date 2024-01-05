class BugsController < ApplicationController
	load_and_authorize_resource
  before_action :set_bug, only: [:show, :edit, :update, :destroy]
  # before_action :authorize_qa, only: [:new, :create, :edit, :update]
  before_action :save_from_url_access

  def new
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.build
  end

  def create
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.build(bug_params)
    @bug.creator = current_user
    if @bug.save
      @bug.users << current_user
      flash[:notice] = "Bug was successfully created"
      redirect_to project_bug_path(@project, @bug)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def index
    @project = Project.find(params[:project_id])
    if current_user.manager?
      @bugs = @project.bugs
    else
      @bugs = current_user.bugs.where(project_id: @project.id)
    end
  end

  def show
    
  end

  def edit
    @project = Project.find(params[:project_id])
    # @bug = Bug.find_by(id: params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    if @bug.update(bug_params)
      flash[:notice] = "Bug was updated successfully!"
      redirect_to project_bug_path(@project, @bug)
    else
      flash[:notice] = "Failed to update the project!"
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    # @bug.bug_users.destroy_all
    @bug.destroy
    redirect_to project_bugs_path(@bug.project_id), notice: "Bug was successfully deleted."
  end

  private

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :bug_type, :status, :deadline, user_ids: [], images: [])
  end

  # def authorize_qa
  #   return if current_user.qa?
  #   redirect_to root_path, alert: 'Only Qa person can create a bug.' unless current_user.qa?
  # end
   
  def save_from_url_access
    redirect_to root_path, notice: 'Access Denied! This is not your project so you cannot create bug for this project' and return unless current_user.projects.pluck(:id).include?(params[:project_id].to_i)
  end 
end
