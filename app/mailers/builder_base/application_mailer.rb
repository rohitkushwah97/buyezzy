module BuilderBase
  class ApplicationMailer < ::ApplicationMailer
    default from: 'care@byezzy.com'
    layout 'mailer'
  end
end
