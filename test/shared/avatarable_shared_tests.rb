# frozen_string_literal: true

module AvatarableSharedTests
  def self.included spec
    spec.class_eval do
      context "avatarable" do
        should "behave as avatarable" do
          assert_includes User.included_modules, Avatarable

          assert subject, respond_to?(:append_avatar=)
        end

        context "validations" do
          should "append error if avatar is too big" do
            fixture_file.stubs(:size).returns(2.megabytes)

            subject.avatar.attach(io: fixture_file, filename: "test.png")

            refute subject.valid?
            assert_includes subject.errors[:avatar], "size must be between 10kb and 1Mb"
          end

          should "append error if avatar is too small" do
            fixture_file.stubs(:size).returns(1.kilobyte)

            subject.avatar.attach(io: fixture_file, filename: "test.png")

            refute subject.valid?
            assert_includes subject.errors[:avatar], "size must be between 10kb and 1Mb"
          end
        end
      end
    end
  end
end
