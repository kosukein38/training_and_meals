require 'rails_helper'

RSpec.describe UserMailer do
  describe 'reset_password_email' do
    let(:mail) { described_class.reset_password_email }

    xit 'renders the headers' do
      expect(mail.subject).to eq('Reset password email')
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq(['from@example.com'])
    end

    xit 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end