class UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def create
    user = User.new(user_params)
    ActionCable.server.broadcast('user_channel', user) if user.save
    render json: user
  end

  def add_message
    user = User.find(params[:user_id])
    message = params[:message]
    created_message = user.messages.create(content: message)
    from = Email.new(email: 'no-reply@wbayudan.com')
    to = Email.new(email: 'wilfredbayudan@gmail.com')
    subject = 'Sending with SendGrid is Fun'
    content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
    mail = Mail.new(from, subject, to, content)
    
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
    head :ok
  end

  def change_status; end

  private

  def user_params
    params.require(:user).permit(:username, :status)
  end
end
