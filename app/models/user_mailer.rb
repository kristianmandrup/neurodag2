class UserMailer < ActionMailer::Base
  
  def reminder(user)
    @subject      = 'Your login information at RailsSpace.com'
    @body         = {}
    # Give body access to the user information.
    @body["user"] = user
    @recipients   = user.email
    @from         = 'RailsSpace <do-not-reply@railsspace.com>'
  end
  
  def message(mail)
    subject     mail[:message].subject
    from        'RailsSpace <do-not-reply@railsspace.com>'
    recipients  mail[:recipient].email
    body        mail
  end

  def friend_request(mail)
    subject     'New friend request at RailsSpace.com'
    from        'RailsSpace <do-not-reply@railsspace.com>'
    recipients  mail[:friend].email
    body        mail
  end
end