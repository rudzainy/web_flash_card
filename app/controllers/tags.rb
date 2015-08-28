get '/view_tags/:id' do

  @tag = Tag.find(params[:id])
  erb :view_tags
end