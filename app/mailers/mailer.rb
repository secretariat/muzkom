class Mailer < ActionMailer::Base
  default from: "noreply@muzkom.com.ua"
  
  def client_purchase_notification
  end
  
  def admin_purchase_notification
  end
  
end
