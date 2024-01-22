# frozen_string_literal: true

class QrsController < ApplicationController
  load_and_authorize_resource
  before_action :set_qr, only: %i[show edit update destroy]
  before_action :set_folder, only: %i[index new create edit update]

  def new
    @qr = @folder ? @folder.qrs.build : Qr.new
  end

  def create
    if @folder.present?
      @qr = @folder.qrs.build(qr_params)
    else
      @qr = Qr.new(qr_params)
    end
    @qr.user = current_user
    if @qr.save
      if @folder.present?
        redirect_to folder_qr_path(@folder, @qr), notice: 'QR was successfully created.'
      else
        redirect_to qr_path(@qr), notice: 'QR was successfully created.'
      end
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def index
    @qrs = if @folder.present?
             if current_user.admin?
               @folder.qrs
             else
               current_user.qrs.where(folder_id: @folder.id)
             end
           elsif current_user.admin?
             Qr.where(folder_id: nil)  # All Qrs which are not associated with any folder
           else
             current_user.qrs.where(folder_id: nil)
           end
  end

  def show; end

  def edit; end

  def update
    if @qr.update(qr_params)
      flash[:notice] = 'QR Code is updated successfully!'
      if @folder
        redirect_to folder_qr_path(@folder, @qr)
      else
        redirect_to qr_path(@qr)
      end
    else
      flash[:notice] = 'Failed to update the QR Code!'
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @qr.destroy
    redirect_to folder_qrs_path(@qr.folder_id), notice: 'QR Code was successfully deleted.'
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
