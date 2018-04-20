class UsersController < ApplicationController
    def register
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id
            redirect_to result_path
        else
            flash[:errors] = user.errors.full_messages
            redirect_to root_path
        end
    end
    def login
        if User.find_by_email(params[:user][:email]).try(:authenticate, params[:user][:password])
            session[:user_id] = User.find_by(email: params[:user][:email]).id
            redirect_to result_path
        else
            flash[:errors] = ["Invalid Combination"]
            redirect_to root_path
        end
    end
    def result
        if no_current_user
            logout
        end
    end
    def logout
        session[:user_id] = nil
        redirect_to root_path
    end
    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
