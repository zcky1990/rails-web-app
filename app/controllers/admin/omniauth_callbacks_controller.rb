class Admin::SessionController < Devise::OmniauthCallbacksController

  def new
    # case params[:login]
    # when 'notauthorize'
    #   @alert = 'Anda tidak mempunyai akses ke dalam backoffice !'
    # end
    super
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    if !session[:return_to].blank?
      redirect_to session[:return_to]
      session[:return_to] = nil
    else
      role = resource.core_user_meta.find_by(meta_key: 'web_role')
      if role.present?
        if role.meta_value == 'administrator' && resource.user_approve_status == "valid-doctor"
          respond_with resource, :location => after_sign_in_path_for(resource)
        else
          sign_out(resource)
          redirect_to '/?login=notauthorize'
        end
      else
        sign_out(resource)
        redirect_to '/?login=notauthorize'
      end
    end
  end
  
end
