require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user1 = User.create!(name: 'Gurbuz', email: 'gurbuz@email.com', password: '123456')
    @user2 = User.create!(name: 'Kalu', email: 'kalu@email.com', password: '123456')
  end

  context 'has associations' do
    it 'can be created' do
      expect(User.first).to eq(@user1)
      expect(User.second).to eq(@user2)
    end


    it 'can have pending friendship requests' do
      expect(@user1.pending_friends).to eq(@user2.pending_friends)
    end

    it 'can have sent friendship requests' do
      expect(@user1.friend_requests).to eq(@user2.friend_requests)
    end

    it 'can have friends' do
      expect(@user1.friends).not_to eq(@user2)
    end

    it 'can check if they are friends with' do
      expect(@user1.friend?(@user2)).to be(false)
    end
  end
end
