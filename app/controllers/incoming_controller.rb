class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # Is the email from one of our users?
    from_address = params[:sender]
    user = User.user_for_email_address(from_address)

    # Does the email body contain at least one url?
    body_plain = params["stripped-text"]
    bookmark_url = URI.extract(body_plain).first

    if user && bookmark_url
      # The email's subject represents a topic. If no subject is present
      # add the bookmark to the "default" topic.
      topic_string = params[:subject]
      if topic_string.blank?
        topic = Topic.default_topic_for_user(user)
      else
        topic = Topic.find_by(title: topic_string)
        if topic.nil?
          topic = Topic.new(title: topic_string, user: user)
        end
      end

      puts "from  : #{from_address}"
      puts "url   : #{bookmark_url}"
      puts "topic : #{topic.title}"
      puts "user  : #{user.name}"
      puts "body  : #{body_plain}"

      bookmark = Bookmark.create!(url: bookmark_url, topic: topic)
      topic.bookmarks << bookmark
      topic.save!
      puts " --- SUCCESS ---"
    end

    # Assuming all went well.
    head 200
  end

end
