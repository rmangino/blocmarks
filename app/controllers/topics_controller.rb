class TopicsController < ApplicationController
  load_and_authorize_resource # CanCanCan gem

  def index
    @topics = Topic.visible_to(current_user)
  end

  def show
    @bookmarks = @topic.bookmarks.includes(:user)
  end

  def new
  end

  def create
    @topic.user = current_user

    if @topic.save
      flash[:notice] = "Topic was created."
      redirect_to root_path
    else
      flash[:error] = "There was an error saving the Topic. Please try again."
      # RRM
      redirect_to :new
    end
  end

  def edit
  end

  def update
    if @topic.update_attributes(topic_params)
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash[:error] = "There was an error saving the topic. Please try again."
      render :root_path
    end
  end

  def destroy
    if @topic.destroy
      flash[:notice] = "Topic deleted."
      redirect_to root_path
    else
      flash[:error] = "There was an error deleting the topic."
      redirect_to :show
    end
  end

private

  def find_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title)
  end
end
