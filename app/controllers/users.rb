# form for logging in
get '/login' do
  #if successful
  erb :login
end

# process login
post '/login' do
  @email = params[:email]
  @password = params[:password]

  if User.authenticate(@email, @password)
    @user = User.find_by email: @email
    session[:user_id] = @user.id
    current_user
    @flag = "Cheers #{@user.name}!" 
    erb :index
  else
    @flag = "Invalid email or password!"
    erb :login
  end
end

# form for signing up
get '/signup' do
  erb :signup
end

# proses new users
post '/signup' do

  @name = params[:name]
  @email = params[:email]
  @password = params[:password]

  if User.check_duplicate(@email) == false
    @flag = "The email has been registered to another account!"
    erb :signup
  else
    @user = User.create(name: @name, email: @email, password: @password)
    @flag = "Account successfully created! You may log in now."
    erb :login
  end
end

# 
get '/secret' do
  if session[:user_id]
    current_user
    # @user = User.find(session[:user_id])
    @property_list = @current_user.properties
    @booking_list = @current_user.bookings
byebug
    erb :secret
  else
    erb :login
  end
end

get '/logout' do
  session[:user_id] = nil
  @flag = "You are successfully logged out."
  erb :index
end

