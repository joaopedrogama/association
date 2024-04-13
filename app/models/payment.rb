class Payment < ApplicationRecord
  belongs_to :person

  after_save :update_balance

  def update_balance
    self.person.balance
  end
end
