
class StaticController < ApplicationController

  enable :sessions
  set :raise_errors, true
  set :show_exceptions, true

# Scope defines what permissions that we are asking the user to grant.
# In this example, we are asking for the ability to publish stories
# about using the app, access to what the user likes, and to be able
# to use their pictures.  You should rewrite this scope with whatever
# permissions your app needs.
# See https://developers.facebook.com/docs/reference/api/permissions/
# for a full list of permissions
  FACEBOOK_SCOPE = 'email'

  unless ENV["FACEBOOK_APP_ID"] && ENV["FACEBOOK_SECRET"]
    abort("missing env vars: please set FACEBOOK_APP_ID and FACEBOOK_SECRET with your app credentials")
  end

  before do
    # HTTPS redirect
    if settings.environment == :production && request.scheme != 'https'
      redirect_to "https://#{request.env['HTTP_HOST']}"
    end
  end

  def host
    request.env['HTTP_HOST']
  end

  def scheme
    request.scheme
  end

  def url_no_scheme(path = '')
    "//#{host}#{path}"
  end

  def url(path = '')
    "#{scheme}://#{host}#{path}"
  end

  def authenticator
    @authenticator ||= Koala::Facebook::OAuth.new(ENV["FACEBOOK_APP_ID"], ENV["FACEBOOK_SECRET"], url("/auth/facebook/callback"))
  end

  def landing

    # Get base API Connection
    @graph  = Koala::Facebook::API.new(session[:access_token])

    # Get public details of current application
    @app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])

    if session[:access_token]
      @user    = @graph.get_object("me")
      #@friends = @graph.get_connections('me', 'friends')
      #@photos  = @graph.get_connections('me', 'photos')
      #@likes   = @graph.get_connections('me', 'likes').first(4)

      # for other data you can always run fql
      #@friends_using_app = @graph.fql_query("SELECT uid, name, is_app_user, pic_square FROM user WHERE uid in (SELECT uid2 FROM friend WHERE uid1 = me()) AND is_app_user = 1")
    else
      redirect '/auth/facebook'
    end

  end

  def fblogin

    session[:access_token] = nil
    session[:user_id] = nil
    redirect_to authenticator.url_for_oauth_code(:permissions => FACEBOOK_SCOPE)

  end

  def setsession
    #session[:access_token] = authenticator.get_access_token(params[:code])

    user = User.from_omniauth(env["omniauth.auth"])
    session[:access_token] = user.oauth_token
    session[:user_id] = user.id

    redirect_to '/'
  end

  def close
    "<body onload='window.close();'/>"
  end

  def fblogout

    session[:access_token] = nil
    session[:user_id] = nil
    redirect_to '/'

  end

  def unauthorized
    # Get base API Connection
    @graph  = Koala::Facebook::API.new(session[:access_token])

    # Get public details of current application
    @app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])

  end

end
