class UsersController < ApplicationController
	def my_portfolio
		@user = current_user
		@user_stocks = @user.stocks
	end

	def my_friends
	    @friendships = current_user.friends
	end

	def search
		if params[:search_param].blank?
			flash.now[:danger] = "You haven't entered search text."
		else
			@users = User.search(params[:search_param])
			@users = current_user.except_current_user(@users)
			flash.now[:danger] = "Searched Term is not there." if @users.blank?
		end
		respond_to do |format|
			format.js { render partial: 'friends/result' }
		end
	end

	def add_friend
		@friend = User.find(params[:friend])
		current_user.friendships.build(friend_id: @friend.id)
		if current_user.save
			flash[:success] = "Friend is successfully added."
		else
			flash[:danger] = "There was something wrong with the friend request."
		end
		redirect_to my_friends_path
	end

	def show
		@user = User.find(params[:id])
		@user_stocks = @user.stocks
	end
end
