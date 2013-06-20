# -*- encoding : utf-8 -*-
class Session < Authlogic::Session::Base
  authenticate_with User
end
