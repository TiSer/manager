ActionMailer::Base.smtp_settings = {
   :address => 'smtp.gmail.com', 
   :port => 587,
   :domain => 'Bla',
   :authentication => :plain,
   :user_name => 'blablabla@gmail.com', 
   :password => '123'
}
