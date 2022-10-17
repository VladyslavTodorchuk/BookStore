class CallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user
      sign_in_and_redirect @user, notice: "Successfully connected with facebook #{auth.info.name}"
    else
      redirect_to root_path, alert: 'There was a problem connection with facebook'
    end
  end
end
