require 'rails_helper'

RSpec.describe UserMailer do
  describe 'reset_password_email' do
    let(:mail) { described_class.reset_password_email }

    it 'renders the headers' do
      skip '後ほど実装1'
    end

    it 'renders the body' do
      skip '後ほど実装2'
    end
  end
end
