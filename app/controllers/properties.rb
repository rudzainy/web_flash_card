get '/new_property' do
  erb :new_property
end

get '/view_property/:id' do

  @property = Property.find(params[:id])
  current_user
  erb :view_property
end

get '/edit_property/:id' do

  @property = Property.find(params[:id])
  erb :edit_property
end

get '/delete_property/:id' do

  @property = Property.find(params[:id])
  Property.destroy(@property)

  erb :delete_property
end

post '/new_property' do
  
  current_user
  @title = params[:title]
  @description = params[:description]
  @user_id = @current_user.id
  @price = params[:price]
  @bed = params[:bed]
  @bathroom = params[:bathroom]
  @tags = params[:tags].split(", ")

  @new_property = Property.new(title: @title, description: @description, bed: @bed, bathroom: @bathroom, price: @price, user_id: @user_id)

  @new_property.save
  if @new_property.save

    @tags.each do |tag|
      @tag = Tag.find_or_create_by(name: tag)
      @tag.properties << @new_property
    end

    @current_user.properties << @new_property

    @flag = "Your property has been created!"
    erb :index
  else
    @flag = "Fields cannot be empty!"
    erb :new_property
  end
end

post '/edit_property/:id' do

  current_user
  @property = Property.find(params[:id])
  @property.title = params[:title]
  @property.description = params[:description]
  @property.user_id = @current_user.id
  @property.price = params[:price]
  @property.bed = params[:bed]
  @property.bathroom = params[:bathroom]
  @tags = params[:tags].split(", ")

  @property.save
  if @property.save

    @tags.each do |tag|
      @tag = Tag.find_or_create_by(name: tag)
      if @tag != nil
        @tag.properties << @property
      end
    end

    @flag = "Property was edited successfully!"
    erb :index
  else
    @flag = "Fields cannot be empty!"
    erb :edit_property
  end
end