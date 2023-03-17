class UsersController < ApplicationController

before_action :current_user,   only: [:edit, :update]

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'Welcome! You have signed up successfully.'
      redirect_to user_path(current_user)
    else
      render :new
    end
    @user = login(params[:name], params[:password])

　　if @user
      flash[:success] = 'Signed in successfully.'
 　　　redirectr_to user_path(current_user)
 　　else
 　　　render :new
　　end
    
  end

  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(params[:id])
       flash[:notice] = "You have updated user successfully."
       redirect_to user_path(user.id)
   else
       render :edit
   end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
