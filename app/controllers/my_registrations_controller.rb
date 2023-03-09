class MyRegistrationsController < Devise::RegistrationsController

  def create
    super
    puts "fired!"
    if @user.persisted?
      UserMailer.with(user: @user).welcome_email.deliver_later
    end
  end

end