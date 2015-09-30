class UserMailer < ApplicationMailer
  default from: 'notifications@ruxica.com'

  def user_deletion_email(user)
    @user = user
    @url = 'http://localhost:3000/'
    email_with_name = %("#{@user.full_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "@user.full_name, your account is now deleted. Good bye!")
  end

end
