class Email::HardJob
  include Sidekiq::Job

  def perform(*args)
    user = User.where(email: 'admin@admin.com').first
    PersonMailer.balance_report(user).deliver_later
  end
end
