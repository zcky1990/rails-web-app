class Admin::UserAdminController < Admin::AdminApplicationController
  def initialize
    @service = Admin::UserAdminService.new
  end

  def index
    if params[:page].present?
      page = params[:page]
    else
      page = 1
    end
    @data = @service.get_admin_list(page)
  end
end
