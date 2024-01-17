class Qr < ApplicationRecord
  #has_one_attached :qr_code_image, dependent: :destroy
  belongs_to :folder, optional: true
  belongs_to :user

  validates_uniqueness_of :name
  validates :name, presence: true
  before_create :user_should_present












  include Rails.application.routes.url_helpers
  has_one_attached :qr_code_image, dependent: :destroy

  before_commit :generate_qr_code_image, on: :create

  private

  def generate_qr_code_image
    # Get the host
    # host = Rails.application.routes.default_url_options[:host]
    host = Rails.application.config.action_controller.default_url_options[:host]
    url = url_for(self)
    # Create the QR code object
    # qr_code_image = RQRCode::QRCode.new("http://#{host}/posts/#{id}")
    qr_code_image = RQRCode::QRCode.new(url)

    # Create a new PNG object
    png = qr_code_image.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 120,
    )

    # Attach the QR code to the active storage
    self.qr_code_image.attach(
      io: StringIO.new(png.to_s),
      filename: "qr_code_image.png",
      content_type: "image/png",
    )
    
  end





  def user_should_present
    unless user.present?
      errors.add(:base, 'A QR code cannot be created without any user. Somebody must be there to create the QR code..... COMMON SENSE!')
      throw(:abort)
    end
  end
end


