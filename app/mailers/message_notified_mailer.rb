class MessageNotifiedMailer < ApplicationMailer
  default :from => 'no-reply@wbayudan.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_message_email
    mail( :to => "wilfredbayudan@gmail.com",
    :subject => 'Thanks for signing up for our amazing app' )
  end
end
