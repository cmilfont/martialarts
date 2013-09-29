# encoding: UTF-8
require 'factory_girl'
Dir[Rails.root.join("#{Rails.root}/spec/factories/**/*.rb")].each {|f| require f}

@user = FactoryGirl.create :user, :email => "cmilfont@gmail.com", :password => "testes55" 

@category = FactoryGirl.create(:category, :name => "Cross lock")

@bjj = FactoryGirl.create(:martialart, :name => "Brazilian Jiu Jitsu")
@judo = FactoryGirl.create(:martialart, :name => "Judo")

@baseballchoke = FactoryGirl.create(:technique, 
  :name => "Baseball Choke", 
  :description => "Baseball choke, or Ura juji jime, is a choke on the Trachea (air choke hold) and blood vessels of the neck, performed at ground fighting from knee on stomach position. This choke is a part of the syllabus of Brazilian Jiu Jitsu, Judo and Budo Ninjutsu.",
  :categories => [@category],
  :martialarts => [@bjj, @judo])

@urajujijime = FactoryGirl.create(:technique, 
  :name => "Ura juji jime - 裹十字絞", 
  :description => "Ura-Juji-Jime is the fourth variation of the cross lock, Juji-Jime, demonstrated in The Canon Of Judo, the first three being Katate-, Gyaku-, and Nami- Juji-Jime.",
  :categories => [@category],
  :martialarts => [@judo])
    
FactoryGirl.create(:video, :link => "http://www.youtube.com/embed/IIWyg-5e87w?html5=1", :technique => @baseballchoke)
FactoryGirl.create(:video, :link => "http://www.youtube.com/embed/87s5aRdrY1w?html5=1", :technique => @baseballchoke)
FactoryGirl.create(:video, :link => "http://www.youtube.com/embed/VvpOSN2PnW0?html5=1", :technique => @baseballchoke)
FactoryGirl.create(:video, :link => "http://www.youtube.com/embed/frbS6PtAG6I?html5=1", :technique => @urajujijime)