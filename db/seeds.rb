# encoding: UTF-8
require 'factory_girl'
Dir[Rails.root.join("#{Rails.root}/spec/factories/**/*.rb")].each {|f| require f}

@user = FactoryGirl.create :user, :email => "cmilfont@gmail.com", :password => "testes55", :admin => true 

#@category = FactoryGirl.create(:category, :name => "Cross lock")

@bjj = FactoryGirl.create(:martialart, :name => "Brazilian Jiu Jitsu")
@judo = FactoryGirl.create(:martialart, :name => "Judo")

@bjj.update_attribute :description, <<-eos
Brazilian Jiu-Jitsu (/dʒuːˈdʒɪtsuː/; Portuguese: [ˈʒiw ˈʒitsu], [ˈʒu ˈʒitsu], [dʒiˈu dʒiˈtsu]) (BJJ) is a martial art, combat sport, and a self defense system that focuses on grappling and especially ground fighting. Brazilian jiu-jitsu was formed from Kodokan Judo ground fighting (Ne-Waza) fundamentals that were taught to Carlos Gracie by master Mitsuyo Maeda. Brazilian jiu-jitsu eventually came to be its own art through the experimentations, practices, and adaptation from the Judo knowledge of Carlos and Hélio Gracie, who then passed their knowledge on to their family.
BJJ promotes the concept that a smaller, weaker person can successfully defend against a bigger, stronger assailant by using leverage and proper technique, taking the fight to the ground – most notably by applying joint-locks and chokeholds to defeat the other person. BJJ training can be used for sport grappling tournaments (gi and no-gi) and mixed martial arts (MMA) competition or self-defense.[4] Sparring (commonly referred to as "rolling") and live drilling play a major role in training, and a premium is placed on performance, especially in competition, in relation to progress and ascension through its ranking system.
Since its inception in 1914, its parent art of Judo was separated from older systems of Japanese ju-jitsu by an important difference that was passed on to Brazilian jiu-jitsu: it is not solely a martial art: it is also a sport; a method for promoting physical fitness and building character in young people; and, ultimately, a way (Do) of life.
eos

@judo.update_attribute :description, <<-eos
Judo (柔道 jūdō?, meaning "gentle way") is a modern martial art, combat and Olympic sport created in Japan in 1882 by Jigoro Kano (嘉納治五郎). Its most prominent feature is its competitive element, where the objective is to either throw or takedown an opponent to the ground, immobilize or otherwise subdue an opponent with a pin, or force an opponent to submit with a joint lock or a choke. Strikes and thrusts by hands and feet as well as weapons defenses are a part of judo, but only in pre-arranged forms (kata(型)) and are not allowed in judo competition or free practice (randori(乱取り)).
The philosophy and subsequent pedagogy developed for judo became the model for other modern Japanese martial arts that developed from koryū (古流?, traditional schools). The worldwide spread of judo has led to the development of a number of offshoots such as Sambo and Brazilian jiu-jitsu. Judo practitioners are called judoka.
eos

@baseballchoke = FactoryGirl.create(:technique, 
  :name => "Baseball Choke", 
  :description => "Baseball choke, or Ura juji jime, is a choke on the Trachea (air choke hold) and blood vessels of the neck, performed at ground fighting from knee on stomach position. This choke is a part of the syllabus of Brazilian Jiu Jitsu, Judo and Budo Ninjutsu.",
  :user => @user)

MartialartTechnique.create :martialart => @bjj, :technique => @baseballchoke
MartialartTechnique.create :martialart => @judo, :technique => @baseballchoke

@urajujijime = FactoryGirl.create(:technique, 
  :name => "Ura juji jime - 裹十字絞", 
  :description => "Ura-Juji-Jime is the fourth variation of the cross lock, Juji-Jime, demonstrated in The Canon Of Judo, the first three being Katate-, Gyaku-, and Nami- Juji-Jime.",
  :user => @user)
  
  MartialartTechnique.create :martialart => @judo, :technique => @urajujijime
    
FactoryGirl.create(:video, :link => "http://www.youtube.com/embed/IIWyg-5e87w?html5=1", :user => @user, :technique => @baseballchoke)
FactoryGirl.create(:video, :link => "http://www.youtube.com/embed/87s5aRdrY1w?html5=1", :user => @user, :technique => @baseballchoke)
FactoryGirl.create(:video, :link => "http://www.youtube.com/embed/VvpOSN2PnW0?html5=1", :user => @user, :technique => @baseballchoke)
FactoryGirl.create(:video, :link => "http://www.youtube.com/embed/frbS6PtAG6I?html5=1", :user => @user, :technique => @urajujijime)