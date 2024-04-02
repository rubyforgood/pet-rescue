module AvatarHelper
  def render_avatar_partial(xl = false)
    partial_name = xl ? "components/xl_avatar" : "components/avatar"

    render partial_name do |partial|
      partial.alt "#{current_user.first_name.first.upcase} Avatar"
      partial.initials "#{current_user.first_name.first}#{current_user.last_name.first}".upcase

      if current_user.avatar.attached?
        partial.avatar do
          image_tag url_for(current_user.avatar), alt: partial.alt, class: (xl ? 'avatar-xl rounded-circle border border-4 border-white' : 'rounded-circle')
        end
      end
    end
  end
end
