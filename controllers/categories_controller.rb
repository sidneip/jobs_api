class CategoriesController < ApplicationController
  before do
    authenticate!
  end

  get '/:id'  do
    @categories = CategoryService.new(params[:id]).calculate
    @categories.to_json
  end
end
