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
      if nil == topic_string
        topic = Topic.default_topic_for_user(user)
      else
# is this an existing or new topic?
        topic = Topic.new(title: topic_string, user: user)
      end

      bookmark = Bookmark.create!(url: bookmark_url, topic: topic)
      topic.update_attributes!(bookmark: bookmark)
      topic.save!
      puts " --- SUCCESS ---"
    end

    # puts "from : #{from_address}"
    # puts "body : #{body_plain}"
    # puts "url  : #{bookmark_url}"
    # puts "user : #{user}"


    # You put the message-splitting and business magic here.
    # Find the user by using params[:sender]
    # Find the topic by using params[:subject]
    # Assign the url to a variable after retreiving it from params["body-plain"]

    # Check if user is nil, if so, create and save a new user

    # Check if the topic is nil, if so, create and save a new topic

    # Now that you're sure you have a valid user and topic, build and save a new bookmark

    # Assuming all went well.
    head 200
  end

end
