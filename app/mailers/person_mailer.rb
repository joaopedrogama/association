require 'csv'

class PersonMailer < ApplicationMailer
    default from: 'admin@admin.com'

    def balance_report(person)
        attributes = %w{name balance}
        csv = CSV.generate() do |csv|
            csv << attributes
            Person.order(:name).each do |people|
                row = [people.name, people.balance]
                csv << row
            end
        end
        attachments['balance_report.csv'] = {
            mime_type: 'text/csv',
            content: csv
        }
        mail(to: person.email, subject: 'Balance Report') do |format|
            format.text { render plain: "Balance report." }
            format.html { render html: "<p>Balance report.</p>".html_safe }
        end
    end
end
