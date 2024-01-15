class QrsController < ApplicationController
  load_and_authorize_resource
  before_action :set_qr, only: [:show, :edit, :update, :destroy]
  before_action :set_folder, only: [:new, :create]

  def new
    #@qr = @folder.qrs.build
    @qr = @folder ? @folder.qrs.build : Qr.new
  end

  def create
    if @folder
      @qr = @folder.qrs.build(qr_params)
    else
      @qr = Qr.new(qr_params)
    end
    @qr.user = current_user
    if @qr.save
      if @folder
        redirect_to folder_qrs_path(@folder), notice: 'QR was successfully created.'
      else
        redirect_to qrs_path, notice: 'QR was successfully created.'
      end
    else
      render 'new', status: :unprocessable_entity
    end
  end



  def index
    if params[:folder_id].present?
      @folder = Folder.find(params[:folder_id])
      if current_user.admin?
        @qrs = @folder.qrs
      else
        @qrs = current_user.qrs.where(folder_id: @folder.id)
      end
    else
      if current_user.admin?
        @qrs = Qr.where(folder_id: nil)  # All Qrs not associated with any folder
      else
        @qrs = current_user.qrs.where(folder_id: nil)
      end
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

  def set_folder
    @folder = Folder.find(params[:folder_id]) if params[:folder_id].present?
  end

  def qr_params
    params.require(:qr).permit(:name, :qr_code_image)
  end

end
