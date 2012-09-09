class SessionUtils
  def self.cleanup
    session_store = ActiveRecord::SessionStore::Session
    session_store.delete_all( ['updated_at <?', 1.month.ago] )
  end
end