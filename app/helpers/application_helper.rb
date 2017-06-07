module ApplicationHelper
  def link_to_add_nested(text, form, association)
    singular_name = association.to_s.singularize
    # form.object == recipe
    # always call public_send(), only access public methods
    # meta programming alert!
    object = form.object.public_send(association).build

    template = form.fields_for(association, object, child_index: "__ID__") do |nested_form|
      render "#{singular_name}_fields", form: nested_form
    end

    link_to text, "#", data: {role: "add-nested", template: template}
  end

  def avatar (user)
    image_tag "http://pix.iemoji.com/images/emoji/apple/8.3/256/weary-cat-face.png", class: "avatar"
  end

  def follow_button(user)
    if current_user.follows?(user)
      button_to t("unfollow"), [:unfollow, user]
    else
      button_to t("follow"), [:follow, user]
    end
  end
end
