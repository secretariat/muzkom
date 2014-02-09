# -*- encoding : utf-8 -*-
class Admin::IndexController < AdminController

  def index
    @usd = Currency.where(:brand_id=>0, :input => "usd", :output=>"uah").first
    @eur = Currency.where(:brand_id=>0, :input => "eur", :output=>"uah").first
    @product_comments = ProductComment.latest
  end

end
