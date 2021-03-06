class InvitationsController < ApplicationController
	# include UsersHelper
	def index
		@posts = Post.where(user_id: current_user.id)
		@invitations_to_you = Invitation.where(invitee_id: current_user.id)
		@invitations_from_you = Invitation.where(user_id: current_user.id)
		#@invitations = Invitation.where("user_id = #{current_user.id} or invitee_id=#{current_user.id}")
	end 

	def new
	end

	def create
		@post = Post.find(params[:post_id])
    	@invitation = @post.invitations.new

    	@invitation.user_id = current_user.id
    	@invitation.status = 0 
    	@invitation.invitee_id = @post.user.id
    	
    	if current_user.id == @post.id
    		flash[:alert] = "Error creating request"
    		redirect_to posts_path
    	else
	    	if @invitation.save
	    		@poster = User.find(@post.user.id)
	    		@guest = current_user
	    		RequestMailer.request_email(@poster, @guest, @post).deliver_later
				flash[:success] = "Invitation sent!"
	    		redirect_to posts_path
	    	else
	    		flash[:alert] = "Error creating request"
	    		redirect_to posts_path
	    	end
	    end
	end


	def confirm #invitation id >:id
		@invitation = Invitation.find_by(id: params[:id])
		if  @invitation.status == 0

			@invitation.status = 1

		    if @invitation.save
		       #return @invitation.status.to_json
		       redirect_to invitations_path
		    else
		       flash[:alert] = "Error confirm request"
		       redirect_to invitations_path 
	    	end

	   	elsif @invitation.status == 1
	  		flash[:alert] = "You have confirmed!"
	  		redirect_to invitations_path
	  	end
	end


	def decline #invitation id >:id
		@invitation = Invitation.find_by(id: params[:id])
		if  @invitation.status == 0

			@invitation.status = -1

		    if @invitation.save
		       #return @invitation.status.to_json
		       flash[:success] = "Cancelled request"
		       redirect_to invitations_path
		    else
		       flash[:alert] = "Error"
		       redirect_to invitations_path 
	    	end

	   	elsif @invitation.status == -1
	  		flash[:alert] = "You have declined!"
	  		redirect_to invitations_path
	  	end

	end

	def buddy
	end
	
	def show

	end

	def destroy
	end

	private

	def invitation_params
		params.require(:invitation).permit(:status, :user_id, :invitee_id, :post_id)

	end

end
