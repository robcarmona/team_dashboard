class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def new
    redirect_to root_path if logged_in?
  end

  def create
    username = params[:session][:username]
    password = params[:session][:password]

    gitbub_user = nil

    # Github Login
    begin
      client = Octokit::Client.new \
        :login    => username,
        :password => password
      github_user = client.user
    rescue => ex
      logger.error ex.message
      flash[:danger] = "Invalid username or password"
      return redirect_to login_path
    end

    # Github found user
    user = User.find_by(github_id: github_user.id)

    # Existing User
    if user.present?
      user.update_attributes(github_attrs(github_user))
      session[:user_id] = user.id
      return redirect_to root_path
    else
      # Create new user and OAuthToken
      token = client
        .create_authorization(
          :scopes => ["user", "repo", "notifications", "read:org", "user:email"],
          :note => "Enspire Software"
        )

      # Create User
      new_user = User.create(
        {
          github_id: github_user.id,
          github_username: github_user.login,
          github_token: token.token
        }
      )
      session[:user_id] = new_user.id
      return redirect_to root_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end

  private
  def github_attrs(github_user)
    {
      github_id: github_user.id,
      github_username: github_user.login,
      name: github_user.name
    }
  end

end
