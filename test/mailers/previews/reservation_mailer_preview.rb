## Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview

    def notification_email_preview
        ReservationMailer.notification_email("sooching4896@gmail.com", "david.nextacademy@gmail.com",1,2)
    end
#notification_email method comes from your mailers folder
end
