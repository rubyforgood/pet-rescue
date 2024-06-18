require "test_helper"

class PageTextTest < ActiveSupport::TestCase
  context "validations" do
    should validate_presence_of(:hero).allow_nil
    should validate_presence_of(:about).allow_nil
  end

  context "#images" do
    context "when no images attached" do
      setup do
        @page_text = create(:page_text)
      end

      should "return []" do
        assert_equal([], @page_text.images)
      end
    end

    context "when hero image attached" do
      setup do
        @page_text = create(:page_text, :with_hero_image)
        @hero_image = @page_text.hero_image
      end

      should "include hero image" do
        assert_includes(@page_text.images, @hero_image)
      end
    end

    context "when about us image attached" do
      setup do
        @page_text = create(:page_text, :with_about_us_image)
        @about_us_image = @page_text.about_us_images[0]
      end

      should "include about us image" do
        assert_includes(@page_text.images, @about_us_image)
      end
    end
  end
end
