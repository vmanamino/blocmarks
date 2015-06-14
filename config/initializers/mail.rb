ActionMailer::Base.smtp_settings = {
  port:  587,
  address:  'smtp.mailgun.org',
  user_name:  ENV['MAILGUN_SMTP_LOGIN'],
  password:  ENV['MAILGUN_SMTP_PASSWORD'],
  domain:  'app010cb000286f4b51a7052764ec5b1754.mailgun.org',
  authentication:  :plain,
  content_type:  'text/html'  
}
ActionMailer::Base.delivery_method = :smtp

# for debugging
ActionMailer::Base.raise_delivery_errors = true

class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.to = 'vmanamino@gmail.com'
    message.cc = nil
    message.bcc = nil
  end
end

# Locally, outgoing mail will be 'intercepted' by the
# above DevelopmentMailInterceptor before going out

if Rails.env.development?
  ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)
end

## !! Still need to setup mailer, but requirements only call for incoming mail