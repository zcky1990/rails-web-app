class Admin::WebMetaController < Admin::AdminApplicationController
  def initialize
    @service = Admin::WebMetaService.new
  end

  def index
    @data = @service.get_web_meta_data
  end
end
