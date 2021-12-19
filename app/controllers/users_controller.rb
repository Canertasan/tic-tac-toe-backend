class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
    find_user
    render json: @user
  end

  def create
    form = UserForm.new(User.new, params)
    service = UserService::Create.call(user: form.object)

    if service.succeeded?
      render json: service.result, status: :created
    else
      render_service_errors(service)
    end
  end

  def find_user_by_name
    user = User.find_by(name: params[:name])
    if user.nil?
      render json: { errors: { detail: "User cannot be found" }}
    else
      render json: user
    end
  end

  private


  def find_user
    @user = User.find(params[:id])
  end
end
