class BugsController < ApplicationController
  # load_and_authorize_resource  # Added this line due to cancancan
  before_action :set_bug, only: [:show, :edit, :update]
  #before_action :require_admin, except: [:index, :show]
  before_action :authorize_qa, only: [:new, :create, :edit, :update]

  def new
    @bug = Bug.new
  end

  def create
    # binding.break
    @bug = Bug.new(bug_params)
    if @bug.save
      flash[:notice] = "Bug was successfully created"
      redirect_to @bug
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def index
    @bugs = Bug.all
  end

  def show
  end

  def edit
  end

  def update
    if @bug.update(bug_params)
      flash[:notice] = "Bug was updated successfully!"
      redirect_to bug_path(@bug)
    else
      flash[:notice] = "Failed to update the project!"
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :bug_type, :status, :deadline)
  end

  # def require_admin
  #   if !(logged_in? && current_user.admin?)
  #     flash[:alert] = "Only admins can perform that action"
  #     redirect_to bugs_path
  #   end
  # end

  def authorize_qa
    redirect_to root_path, alert: 'Only Qa person can create a bug.' unless current_user.qa?
  end

end
