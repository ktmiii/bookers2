class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path(@book.id)
    else
      @books =Book.new
      @user = current_user
      render :index
    end
  end

  def edit
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.all
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  def update
    @book = Book.find(params[:id])
    if @book.update
       flash[:notice] = "You have updated user successfully."
       redirect_to book_path(book.id)
   else
       render :edit
   end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
