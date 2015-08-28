get '/book_property/:id' do

  if session[:user_id]
	  @property = Property.find(params[:id])
	  current_user
	  erb :book_property
	else
		@flag = "Please log in or sign up to book a property."
		erb :login
	end
end

post '/book_property/:id' do
	current_user
  @check_in = Date.parse(params[:start_day] + " " + params[:start_month] + " " + params[:start_year])
  @check_out = Date.parse(params[:end_day] + " " + params[:end_month] + " " + params[:end_year])
  @user_id = @current_user.id
  @property = Property.find(params[:id])

  @new_booking = Booking.new(user_id: @user_id, property_id: @property.id, start_date: @check_in, end_date: @check_out)

  @new_booking.save
  if @new_booking.save
  	@flag = "Your property has been created!"
    erb :index
  else
  	@flag = "Booking failed!"
    erb :index
  end
end