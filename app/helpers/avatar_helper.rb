module AvatarHelper
  def render_avatar_partial
    render "components/avatar" do |partial|
      partial.alt "#{current_user.first_name.first.upcase} Avatar"
      partial.initials "#{current_user.first_name.first}#{current_user.last_name.first}".upcase

      if current_user.avatar.attached?
        partial.avatar do
          image_tag url_for(current_user.avatar), alt: partial.alt, class: "rounded-circle"
        end
      end
    end
  end
end
