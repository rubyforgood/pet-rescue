# frozen_string_literal: true

require "test_helper"

class ImageAttachmentTableComponentTest < ViewComponent::TestCase
  context "when images is empty" do
    setup do
      @component = ImageAttachmentTableComponent.new(images: [])
      render_inline(@component)
    end

    should "show 'No images attached' text" do
      assert_text("No images attached")
    end
  end

  context "when images is not empty" do
    setup do
      ActiveStorage::Current.url_options = {host: "localhost", port: 3000}

      page_text = create(:page_text, :with_about_us_image)
      @component = ImageAttachmentTableComponent.new(images: page_text.images)
      @image = page_text.images[0]

      render_inline(@component)
    end

    should "render link to image file with filename" do
      assert_selector("a[href*='#{@image.filename}']", text: @image.filename.to_s, count: 1)
    end

    should "render image of image file" do
      assert_selector("img[src*='#{@image.filename}']", count: 1)
    end
  end
end
