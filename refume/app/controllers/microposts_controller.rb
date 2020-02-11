class MicropostsController < ApplicationController
	def new
		@micropost = Micropost.new
	end

	def create
		@micropost = Micropost.new(micropost_params)
		if @micropost.save
      		flash[:success] = "Post success!"
      		# TODO: redirect to a view displaying current post
        	redirect_to @micropost
    	else
    		# TODO: render a 'new micropost' form view, display it here
      		render 'new'
    	end
	end

	private
		def micropost_params
			params.require(:micropost).permit(:content, :user_id, :category_id)
		end

end