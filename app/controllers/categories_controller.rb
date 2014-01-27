class CategoriesController < ApplicationController
	skip_before_action :verify_authenticity_token
	
	def index
		@categories = Category.all

		respond_to do |format|
			format.html
			format.json {
				output = {
					:success => true,
					:result => @categories
				}

				render json: output
			}
		end
	end

	def new
		@category = Category.new		
	end

	def edit
		@category = Category.find(params[:id])
	end

	def show
		@category = Category.find(params[:id])
	end

	def create
		@category = Category.new(
			params.require(:category).permit(:text)
		)

		if @category.save
			respond_to do |format|
				format.html {
					redirect_to @category
				}

				format.json {
					output = {
						:success => true,
						:result => @category
					}

					render json: output
				}
			end			
		else			
			respond_to do |format|
				format.html {
					render 'new'
				}

				format.json {
					output = {
						:success => false,
						:error => @category.errors.full_messages
					}

					render json: output
				}
			end
		end
	end

	def update
		@category = Category.find(params[:id])

		if @category.update(params.require(:category).permit(:text))			
			format.html {
				redirect_to @category
			}

			format.json {
				output = {
					:success => true,
					:result => @category
				}

				render json: output
			}
		else			
			format.html {
				render 'edit'
			}

			format.json {
				output = {
					:success => false,
					:error => @category.errors.full_messages
				}

				render json: output
			}
		end
	end

	def destroy
		@category = Category.find(params[:id])

		if Content.where(:category_id => params[:id]).update_all('category_id = 1')
			if @category.destroy
				format.html {
					redirect_to categories_path
				}

				format.json {
					output = {
						:success => true
					}

					render json: output
				}
			else
				format.html {
					redirect_to categories_path
				}

				format.json {
					output = {
						:success => false,
						:error => @category.errors.full_messages
					}

					render json: output
				}
			end
		else
			format.html {
				redirect_to categories_path
			}

			format.json {
				output = {
					:success => false,
					:error => 'failed to update dependent'
				}

				render json: output
			}				
		end		
	end
end
