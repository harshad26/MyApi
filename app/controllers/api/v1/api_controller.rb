class Api::V1::ApiController < ApplicationController
	respond_to :json

	def sign_up
		if params[:subdomain].present? and params[:api_key].present?
			@user = User.where("username = ? OR  api_key = ? OR subdomain = ?", params[:username], params[:api_key], params[:subdomain])
			if !@user.present?
				@user = User.create(username: params[:username], email: params[:email], password: params[:password], api_key: params[:api_key], subdomain: params[:subdomain])
				if @user.save 
					Apartment::Tenant.create(@user.subdomain)
					render json: {data: @user, message: "User Sign Up Completed", status: 201}
		    else
		      render json: {message: "User is Not Creted", status: 500}
				end
			else
				render json: {message: "User Already exist with same data."}
			end
		else
			render json: {message: "Please Provide Subdomain And Api Key"}
		end
	end

	def sign_in
		if params[:api_key].present?
			@user = User.find_by_api_key(params[:api_key])
		elsif params[:username].present? and params[:password].present?
			@user = User.find_by_username_and_password(params[:username], params[:password])
		end
		if @user and @user.present? 
			render json: {message: "User Sign In Successfully", status: 200}
    else
      render json: {message: "User Not Found", status: 500}
		end
	end

end
