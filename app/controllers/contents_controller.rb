class ContentsController < ApplicationController
	skip_before_action :verify_authenticity_token
	
	def index
		@contents = Content.all		

		categoryId = params[:category_id]
		if categoryId
			@contents = Content.find(:all, :conditions => {:category_id => categoryId})
		end

		respond_to do |format|
			format.html {
				@categories = Category.all
			}

			format.json {
				output = {
					:success => true,
					:result => @contents
				}

				render json: output
			}
		end
	end

	def new
		@content = Content.new
		@categories = Category.all
	end	

	def edit
		@content = Content.find(params[:id])
		@categories = Category.all
	end

	def show
		@content = Content.find(params[:id])
		@categories = Category.all

		respond_to do |format|
			format.html
			format.json {
				output = {
					:success => true,
					:result => @content
				}

				render json: output
			}
		end
	end

	def create
		@content = Content.new(
			params.require(:content).permit(
				:title,
				:subtitle,
				:category_id,
				:text
			)
		)

		if @content.save
			respond_to do |format|
				format.html {
					redirect_to @content
				}

				format.json {
					output = {
						:success => true,
						:result => @content
					}

					render json: output
				}
			end			
		else			
			respond_to do |format|
				format.html {
					@categories = Category.all
					render 'new'
				}

				format.json {
					output = {
						:success => false,
						:error => @content.errors.full_messages
					}

					render json: output
				}
			end
		end
	end

	def update
		@content = Content.find(params[:id])

		if( @content.update(
				params.require(:content).permit(
					:title,
					:subtitle,
					:category_id,
					:text
				)
			)
		)
			respond_to do |format|
				format.html {
					redirect_to @content
				}

				format.json {
					output = {
						:success => true,
						:result => @content
					}

					render json: output
				}
			end			
		else
			respond_to do |format|
				format.html {
					@categories = Category.all
					render 'edit'
				}

				format.json {
					output = {
						:success => false,
						:error => @content.errors.full_messages
					}
				}
			end			
		end
	end

	def destroy
		@content = Content.find(params[:id])
		
		if @content.destroy
			respond_to do |format|
				format.html {
					redirect_to contents_path
				}

				format.json {
					output = { :success => true }
					render json: output
				}
			end
		else
			respond_to do |format|
				format.html {
					redirect_to contents_path
				}

				format.json {
					output = {
						:success => false,
						:error => @content.errors.full_messages
					}

					render json: output
				}
			end
		end		
	end
end
