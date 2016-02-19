class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def new
    redirect_to root_path if logged_in?
  end

  # TODO github login
  def create
    username = params[:session][:username]
    password = params[:session][:password]

    user = User.find_by(github_username: username)

    if user.present?

    else
      client = Octokit::Client.new \
        :login    => username,
        :password => password
    end



    redirect_to login_path
  end

  def destroy
  end

end
