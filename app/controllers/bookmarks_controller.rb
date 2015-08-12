class BookmarksController < ApplicationController
  load_and_authorize_resource # CanCanCan gem

  def show
  end

  def new
    @topic = Topic.find(params[:topic_id])
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark.topic = @topic
    if @bookmark.save
      flash[:notice] = "Bookmark was saved."
      redirect_to root_path
    else
      flash[:error] = "There was an error saving the bookmark. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @bookmark.update_attributes(bookmark_params)
      flash[:notice] = "Bookmark was updated."
      redirect_to root_path
    else
      flash[:error] = "There was an error saving the bookmark. Please try again."
      render :edit
    end

  end

  def destroy
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
