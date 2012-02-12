# encoding: utf-8
class Mailer < ActionMailer::Base
  default :from => "noreply@muzkom.com.ua"
  default_url_options[:host] = "muzkom.com.ua"
  
  def client_purchase_notification(checkout)
    @checkout = checkout
    mail(:to=>@checkout.email, :subject => "Ваш заказ на сайте muzkom.com.ua")
  end
  
  def admin_purchase_notification(checkout)
    @checkout = checkout
    mail(:to=>['info@muzkom.com.ua'], :subject => "Добавлен заказ на сайте muzkom.com.ua")
  end
  
end
