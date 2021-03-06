require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  describe '#log_in' do
    it 'assigns user_id to session user_id' do
      user = User.new(first_name: 'Bob', last_name: 'Bear', email: 'bob@bear.com', password: 'bobby')
      log_in(user)
      expect(session[:user_id]).to eq user.id
    end
  end

  describe '#current_user' do
    it "assigns the current user an id" do
      user = User.create!(first_name: 'Bob', last_name: 'Bear', email: 'bob@bear.com', password: 'bobby')
      log_in(user)
      expect(current_user).to eq user
    end
  end

  describe '#logged_in?' do
    it "checks if there is a current user" do
      user = User.create!(first_name: 'Bob', last_name: 'Bear', email: 'bob@bear.com', password: 'bobby')
      log_in(user)
      expect(logged_in?).to eq true 
    end
  end
end
