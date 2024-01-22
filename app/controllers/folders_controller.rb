# frozen_string_literal: true

class FoldersController < ApplicationController
  load_and_authorize_resource
  before_action :set_folder, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[create update]

  def show; end

  def index
    @folders = if current_user.admin?
                 Folder.all
               else
                 current_user.folders
  end

    # Following work is done for excel sheet (To display data in excel sheet)
    @users = User.all
    respond_to do |format|
      format.xlsx do
        render xlsx: 'index', disposition: 'attachment', filename: 'FMS.xlsx'
      end
      format.html { render :index }
    end
    # Ye upar wala kaam excel sheet k liye
  end

  def new
    @folder = Folder.new
  end

  def edit; end

  def create
    @folder = Folder.new(folder_params)
    @folder.user = current_user
    if @folder.save
      flash[:notice] = 'Folder is created successfully!'
      redirect_to folder_path(@folder)
    else
      flash[:notice] = 'Failed to create folder!'
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    if @folder.update(folder_params)
      flash[:notice] = 'Folder was updated successfully!'
      redirect_to folder_path(@folder)
    else
      flash[:notice] = 'Failed to update the folder!'
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @folder.destroy
    redirect_to folders_path
  end

  private

  def set_folder
    @folder = Folder.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:name, :description)
  end

  def authorize_admin
    redirect_to root_path, alert: 'Only admins can create folders.' unless current_user.admin?
  end
end
