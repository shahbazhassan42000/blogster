module ApplicationHelper
  def dashboard_url(user)
    "http://#{user.company.slug}.#{APP_HOST}/user/#{user.id}"
  end

  # Helper method to get the image URL from Active Record for a resource or use the default image
  def resource_image_url(resource, attachment_name, default_image_path)
    if resource.present? && resource.respond_to?(attachment_name) && resource.send(attachment_name).attached?
      url_for(resource.send(attachment_name))
    else
      default_image_path
    end
  end
end
