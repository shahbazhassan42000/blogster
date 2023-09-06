class ApplicationController < ActionController::Base
  def render404
    render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false
  end
end
