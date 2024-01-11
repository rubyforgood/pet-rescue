module Avatarable
  extend ActiveSupport::Concern

  included do
    has_one_attached :avatar

    validates :avatar, content_type: { in: ["image/png", "image/jpeg"],
                                      message: "must be PNG or JPEG" },
      size: { between: 10.kilobyte..1.megabytes,
             message: "size must be between 10kb and 1Mb" }
  end
end
