namespace :db do
  namespace :sessions do
    desc "Clean up expired Active Record sessions (updated before ENV['EXPIRE_AT'], defaults to 1 month ago)."
    task :expire => :environment do
      Rails.logger.info "Cleaning up expired sessions..."
      puts "Cleaning up expired sessions..."
      time = ENV['EXPIRE_AT'] || 1.month.ago.to_s(:db)
      rows = ActiveRecord::SessionStore::Session.delete_all ["updated_at < ?", time]
      Rails.logger.info "Expired sessions cleanup: #{rows} session row(s) deleted."
      puts "Expired sessions cleanup: #{rows} session row(s) deleted."
    end
  end
end