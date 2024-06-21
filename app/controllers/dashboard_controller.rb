class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @dashboard = DashboardService.new(current_user).call
    @last_payments_above_100_thousand = DashboardService.new(current_user).last_payments_above_100_thousand
  end
end
