class InitializeData < ActiveRecord::Migration
  def self.up
    admin = User.create(:screen_name => 'admin', :email => 'rune2earth-admin@gmail.com', :password => 'admin', :role => 'admin', :first_name => 'Rune', :last_name => 'Berg (Admin)')
    admin.save!
    
    ref = User.create(:screen_name => 'referee', :email => 'rune2earth-ref@gmail.com', :password => 'referee', :role => 'referee', :first_name => 'Rune', :last_name => 'Berg (Ref)')
    ref.save!
    
    user = User.create(:screen_name => 'user', :email => 'rune2earth-user@gmail.com', :password => 'user', :role => 'user', :first_name => 'Rune', :last_name => 'Berg (User)')    
    user.save!

    user = User.create(:screen_name => 'user2', :email => 'rune2earth-user@gmail.com', :password => 'user2', :role => 'user', :first_name => 'Rune', :last_name => 'Berg (User2)')    
    user.save!
    
    conf = Conference.create(:title => 'Neurodag 2009', :year => Date.parse("2009/11/01"), :venue => 'Biocentret')
    conf.save!    
    
    talk1 = Talk.create(:title => 'Talk 1 - user', :abstract => "My talk 1", :user_id => User.find_by_screen_name('user'))
    talk2 = Talk.create(:title => 'Talk 2 - admin', :abstract => "My talk 2", :user_id => User.find_by_screen_name('admin'))
    talk3 = Talk.create(:title => 'Talk 3 - user2', :abstract => "My talk 2", :user_id => User.find_by_screen_name('user2'))

    talk1.save!
    talk2.save!
    talk3.save!
  end

  def self.down
  end
end
