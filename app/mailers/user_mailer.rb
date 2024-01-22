# frozen_string_literal: true

class UserMailer < ApplicationMailer
  # default from: 'umarazhar.ua1122@gmail.com'
  # layout 'mailer'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Rails-7 Web App')
  end
end
