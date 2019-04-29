class SessionsController <ApplicationController
  def new 

  end

  def create 
    if request.env["omniauth.auth"]

       @user = User.find_or_create_by(uid: auth['uid']) do |u|
          u.name = auth['info']['username']
          u.email = auth['info']['email']
         
          
        end

        @user.password = SecureRandom.hex(9)
       @user.save

       
          session[:user_id] = @user.id
          redirect_to edit_user_path(@user.id)
         # redirect_to dashboard_path(@user.id)
       else
      user = User.find_by(email: params[:user][:email].downcase)
      if user && user.authenticate(params[:user][:password])
          session[:user_id] = user.id
          redirect_to root_path(user.id)
       else
          flash[:danger] = "Email/Password Incorect"
          render 'new'
       end

    end

  end

  def destroy 
     session.clear 
     redirect_to root_path
  end

  private

def auth
  request.env['omniauth.auth']
end
end