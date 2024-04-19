class Debt < ApplicationRecord
  belongs_to :person

  validates :amount, presence: true

  after_commit :update_balance

  def update_balance
    Rails.cache.delete("#{person.cache_key_with_version}/balance")
    self.person.balance
  end
end
