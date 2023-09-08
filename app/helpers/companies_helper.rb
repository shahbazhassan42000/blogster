module CompaniesHelper
  def current_user_is_owner?
    current_user == @company.owner
  end
end
