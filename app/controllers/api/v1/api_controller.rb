class Api::V1::ApiController < ApplicationController
	respond_to :json

	def sign_up
		@user = User.create(username: params[:username], email: params[:email], password: params[:password], api_key: params[:api_key], subdomain: params[:subdomain])
		if @user.save 
			Apartment::Tenant.create(@user.subdomain)
			render json: {data: @user, message: "User Created", status: 201}
    else
      render json: {message: "User Not Creted", status: 500}
		end
	end

	def sign_in
		if params[:api_key].present?
			@user = User.find_by_api_key(params[:api_key])
		else
			@user = User.find_by_username_and_password(params[:username], params[:password])
		end
		if @user 
			render json: {message: "User Found", status: 200}
    else
      render json: {message: "User Not Creted", status: 500}
		end
	end

end
