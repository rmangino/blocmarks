class BookmarksController < ApplicationController
  def show
    find_bookmark
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Wiki.new(bookmark_params)
    @bookmark.user = current_user

    if @bookmark.save
      flash[:notice] = "Bookmark was saved."
      redirect_to @bookmark
    else
      flash[:error] = "There was an error saving the bookmark. Please try again."
      render :new
    end
  end

  def edit
    find_bookmark
  end

  def update
    find_bookmark

    if @bookmark.update_attributes(bookmark_params)
      flash[:notice] = "Bookmark was updated."
      redirect_to @bookmark
    else
      flash[:error] = "There was an error saving the bookmark. Please try again."
      render :edit
    end

  end

  def destroy
    find_bookmark

    @bookmark.destroy
    flash[:notice] = "Bookmark deleted."
    redirect_to root_path
  end

private

  def find_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end
end
