class Payment < ApplicationRecord
  belongs_to :person

  after_commit :update_balance

  def update_balance
    Rails.cache.delete("#{person.cache_key_with_version}/balance")
    self.person.balance
  end
end
