class PersonMailerService < ApplicationService
    def call
        CSV.generate() do |csv|
            attributes = %w{name balance}
            csv << attributes
            Person.order(:name).each do |people|
                row = [people.name, people.balance]
                csv << row
            end
        end
    end

end
