class QrsController < ApplicationController
  load_and_authorize_resource
  before_action :set_qr, only: [:show, :edit, :update, :destroy]

  def new
    @folder = Folder.find(params[:folder_id])
    @qr = @folder.qrs.build
  end

  def create
    @folder = Folder.find(params[:folder_id])
    @qr = @folder.qrs.build(qr_params)
    if @qr.save
      flash[:notice] = "Qr was successfully created"
      redirect_to folder_qr_path(@folder, @qr)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def index
    @folder = Folder.find(params[:folder_id])
    if current_user.admin?
      @qrs = @folder.qrs
    else
      @qrs = current_user.qrs.where(folder_id: @folder.id)
    end
  end

  def show
    
  end

  def edit
    @folder = Folder.find(params[:folder_id])
  end

  def update
    @folder = Folder.find(params[:folder_id])
    if @qr.update(qr_params)
      flash[:notice] = "QR Code is updated successfully!"
      redirect_to folder_qr_path(@folder, @qr)
    else
      flash[:notice] = "Failed to update the QR Code!"
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @qr.destroy
    redirect_to folder_qrs_path(@qr.folder_id), notice: "QR Code was successfully deleted."
  end

  private

  def set_qr
    @qr = Qr.find(params[:id])
  end

  def qr_params
    params.require(:qr).permit(:name, :qr_code_image)
  end

end
