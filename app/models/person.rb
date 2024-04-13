class Person < ApplicationRecord
  belongs_to :user, optional: true

  has_many :debts, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :name, :national_id, presence: true
  validates :national_id, uniqueness: true
  validate :cpf_or_cnpj

  def balance
    puts "Fetching #{cache_key_with_version }/balance"
    Rails.cache.fetch("#{cache_key_with_version }/balance", expires_in: 1.hour) do
      (payments.sum(:amount) - debts.sum(:amount))
    end
  end

  private

  def cpf_or_cnpj
    if !CPF.valid?(national_id) && !CNPJ.valid?(national_id)
      errors.add :national_id, :invalid
    end
  end
end
