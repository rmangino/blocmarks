class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # puts "INCOMING PARAMS HERE: #{params}"

    from_address = params[:sender]
    user = User.user_for_email_address(from_address)
    title = params[:subject]
    body_plain = params["stripped-text"]

    puts "from : #{from_address}"
    puts "title: #{title}"
    puts "body : #{body_plain}"
    puts "user : #{user}"


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
