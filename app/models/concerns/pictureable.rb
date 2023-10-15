module Pictureable
  extend ActiveSupport::Concern
  
  included do
    has_one_attached :picture
  
    validates :picture, content_type: {in: ["image/png", "image/jpeg"],
                                               message: "must be PNG or JPEG"},
                                size: {between: 10.kilobyte..1.megabytes,
                                       message: "size must be between 10kb and 1Mb"}
  end

  def append_picture=(attachable)
    picture.attach(attachable)
  end
end
