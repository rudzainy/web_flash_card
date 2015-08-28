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
    @flag = "Cheers #{@user.name}!" 
    redirect to '/'
  else
    @flag = "Invalid email or password!"
    redirect to '/login'
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
    redirect to '/signup'
  else
    @user = User.create(name: @name, email: @email, password: @password)
    @flag = "Account successfully created! You may log in now."
    redirect to '/login'
  end
end

get '/secret' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    erb :secret
  else
    redirect '/sign_in'
  end
end

post '/logout' do
  session[:user_id] = nil
  redirect to '/'
end

