class CategoriesController < Sinatra::Base
  get '/:id' do
    @categories = CategoryService.new(params[:id]).calculate
    @categories.to_json
  end
end
