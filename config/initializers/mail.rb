if !Rails.env.test?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address              => ENV['WK_SMTP_ADDRESS'],
    :port                 => 587,
    :domain               => 'gmail.com',
    :user_name            => ENV['WK_SMTP_USER'],
    :password             => ENV['WK_SMTP_PASSWORD'],
    :authentication       => 'plain',
    :enable_starttls_auto => true  }
end
