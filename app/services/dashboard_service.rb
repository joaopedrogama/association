class DashboardService < ApplicationService

    def initialize(user)
        @user = user
    end

    def last_debts_above_100_thousand
        Debt.where("amount > 100000").includes(:person).order(created_at: :desc).limit(10)
    end

    def call
        Rails.cache.fetch("dashboard", expires_in: 1.hour) do
            dashboard_data = {}

            dashboard_data[:active_people_pie_chart] = {
            active: Person.where(active: true).count,
            inactive: Person.where(active: false).count
            }

            active_people_ids = Person.where(active: true).select(:id)
            dashboard_data[:total_debts] = Debt.where(person_id: active_people_ids).sum(:amount)
            dashboard_data[:total_payments] = Payment.where(person_id: active_people_ids).sum(:amount)
            dashboard_data[:balance] = dashboard_data[:total_payments] - dashboard_data[:total_debts]

            dashboard_data[:last_debts] = Debt.order(created_at: :desc).limit(10).map do |debt|
            [debt.id, debt.amount]
            end

            dashboard_data[:last_payments] = Payment.order(created_at: :desc).limit(10).map do |payment|
            [payment.id, payment.amount]
            end

            dashboard_data[:my_people] = Person.where(user: @user).order(:created_at).limit(5)

            people = Person.all.select { |person| person.balance > 0 }
            dashboard_data[:top_person] = people.last
            dashboard_data[:bottom_person] = people.first

            dashboard_data
        end
      end
    end
