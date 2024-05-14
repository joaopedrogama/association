require 'csv'

class PersonMailer < ApplicationMailer
    default from: 'admin@admin.com'

    def balance_report(person)
        csv = PersonMailerService.call
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
