require "test_helper"

class CustomPageTest < ActiveSupport::TestCase
  context "validations" do
    should validate_presence_of(:hero).allow_nil
    should validate_presence_of(:about).allow_nil
  end

  context "#images" do
    context "when no images attached" do
      setup do
        @custom_page = create(:custom_page)
      end

      should "return []" do
        assert_equal([], @custom_page.images)
      end
    end

    context "when hero image attached" do
      setup do
        @custom_page = create(:custom_page, :with_hero_image)
        @hero_image = @custom_page.hero_image
      end

      should "include hero image" do
        assert_includes(@custom_page.images, @hero_image)
      end
    end

    context "when about us image attached" do
      setup do
        @custom_page = create(:custom_page, :with_about_us_image)
        @about_us_image = @custom_page.about_us_images[0]
      end

      should "include about us image" do
        assert_includes(@custom_page.images, @about_us_image)
      end
    end
  end
end
