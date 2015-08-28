get '/new_property' do
  erb :new_property
end

get '/view_property/:id' do

  @property = Property.find(params[:id])
  erb :view_property
end

get '/edit_property/:id' do

  @property = Property.find(params[:id])
  erb :edit_property
end

get '/delete_post/:id' do

  @property = Property.find(params[:id])
  Property.destroy(@property)

  erb :delete_post
end

post '/new_property' do

  @title = params[:title]
  @description = params[:description]
  @user = current_user
  @price = params[:price]
  @bed = params[:bed]
  @bathroom = params[:bathroom]
  @tags = params[:tags].split(", ")

  @new_property = Property.new(title: @title, description: @description, bed: @bed, bathroom: @bathroom, price: @price)

  @new_property.save
  if @new_property.save

    @tags.each do |tag|
      @tag = Tag.find_or_create_by(name: tag)
      @tag.properties << @new_property
    end

    @user.properties << @new_property

    erb :index
  else
    @error = "Fields cannot be empty!"
    erb :new_property
  end
end

post '/edit_property/:id' do

  @property = Property.find(params[:id])
  @property.title = params[:title]
  @property.description = params[:description]
  @owner = current_user.id
  @property.price = params[:price]
  @property.bed = params[:bed]
  @property.bathroom = params[:bathroom]
  @tags = params[:tags].split(", ")

  @tags.each do |tag|
    if Tag.find_by(name: tag) == nil
      @tag = Tag.find_or_create_by(name: tag)
      @tag.posts << @property
    end
  end

  @property.save
  if @property.save
    erb :index
  else
    @error = "Fields cannot be empty!"
    erb :edit_property
  end
end