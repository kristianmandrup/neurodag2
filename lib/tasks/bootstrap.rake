namespace :bootstrap do
    desc "Add the default user"
    task :default_users => :environment do
       User.delete_all
       User.create(:screen_name => 'rune', :email => 'rune2earth-admin@gmail.com', :password => 'admin', :role => 'admin', :first_name => 'Rune', :last_name => 'Berg')
       User.create(:screen_name => 'referee', :email => 'rune2earth-ref@gmail.com', :password => 'referee', :role => 'referee', :first_name => 'Rune', :last_name => 'Berg')
       User.create(:screen_name => 'user', :email => 'rune2earth-user@gmail.com', :password => 'user', :role => 'user', :first_name => 'Rune', :last_name => 'Berg')    
       User.create(:screen_name => 'user2', :email => 'rune2earth-user2@gmail.com', :password => 'user2', :role => 'user', :first_name => 'Rune', :last_name => 'Berg')    
    end

    desc "Create the default conference"
    task :default_conference => :environment do
      Conference.delete_all
      Conference.create(:title => 'Neurodag 2009', :year => Date.parse("2009/11/06"), :venue => 'Copenhagen Biocenter')
    end

    desc "Create the default talks"
    task :default_talks => :environment do
      Talk.delete_all
      Talk.create(:title => 'Talk 1 - user',  :abstract => "My talk 1", :user_id => User.find_by_screen_name('user').id,:conference_id => Conference.first.id )
      Talk.create(:title => 'Talk 2 - admin', :abstract => "My talk 2", :user_id => User.find_by_screen_name('rune').id,:conference_id => Conference.first.id )
      Talk.create(:title => 'Talk 3 - user2', :abstract => "My talk 2", :user_id => User.find_by_screen_name('user2').id,:conference_id => Conference.first.id )
    end

    desc "Create the default registrations"
    task :default_registrations => :environment do
      Registration.delete_all
      Registration.create(:user_id => User.find_by_screen_name('rune').id, :conference_id => Conference.first.id, :bringing_posters => true)
      Registration.create(:user_id => User.find_by_screen_name('referee').id, :conference_id => Conference.first.id, :bringing_posters => true)
      Registration.create(:user_id => User.find_by_screen_name('user').id, :conference_id => Conference.first.id, :bringing_posters => true, :participate_competition => true)
      Registration.create(:user_id => User.find_by_screen_name('user2').id, :conference_id => Conference.first.id, :bringing_posters => true, :participate_competition => true)
    end

   desc "Create the default posters"
   task :default_posters => :environment do
     Poster.delete_all
     Poster.create(:title => 'Poster 1 ', :abstract => "My talk 1", :user_id => User.find_by_screen_name('user').id, :conference_id => Conference.first.id, :registration_id => Registration.first.id)
     Poster.create(:title => 'Poster 2 ', :abstract => "My talk 1", :user_id => User.find_by_screen_name('user2').id, :conference_id => Conference.first.id, :registration_id => Registration.first.id)
     Poster.create(:title => 'Poster 3 ', :abstract => "My talk 1", :user_id => User.find_by_screen_name('rune').id, :conference_id => Conference.first.id, :registration_id => Registration.first.id)
   end


   desc "Create the default posters"
   task :default_pages => :environment do
    Page.create(:title => 'Home', :conference_id => Conference.first.id )
    Page.create(:title => 'Program', :conference_id => Conference.first.id )
    Page.create(:title => 'Presentation competition', :conference_id => Conference.first.id )
    Page.create(:title => 'Plenary Speakers', :conference_id => Conference.first.id )
    Page.create(:title => 'Venue', :conference_id => Conference.first.id )
    Page.create(:title => 'Funding', :conference_id => Conference.first.id )
   end



    desc "Run all bootstrapping tasks"
    task :all => [:default_users, :default_conference, :default_talks, :default_registrations, :default_posters,:default_pages]
end
  
  
  
  
  
  