# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Cleaning Training Session..."
TrainingSession.destroy_all

puts "Cleaning Training..."
Training.destroy_all

puts "Cleaning Training Plan..."
TrainingPlan.destroy_all

puts "Cleaning Run..."
Run.destroy_all

puts "Cleaning Objective..."
Objective.destroy_all

puts "Cleaning Race..."
Race.destroy_all

puts "Cleaning User..."
User.destroy_all

# Users
user1 = User.create!(email:'matthieu@lewagon.com', password: 'password', first_name: 'Matthieu', last_name:'Delegrange')
user2 = User.create!(email:'valentin@lewagon.com', password: 'password', first_name: 'Valentin', last_name:'Burgaud')
user3 = User.create!(email:'pierre@lewagon.com', password: 'password', first_name: 'Pierre', last_name:'Hamon')

puts "Users Created"

#Races
race1 = Race.create!(name: 'Marathon de Marseille ' , date:'2019-04-24' , distance: 42195, address: 'Esplanade du J4 - Mucem , 13002 Marseille ', city: 'Marseille',
	url: 'http://www.runinmarseille.com/fr', limit_date: '2019-04-15')

race2 = Race.create!(name: 'Run in Marseille', date:'2019-03-24' , distance: 21097, address: 'Bouches du Rhône, 13002 Marseille', city: 'Marseille',
	url: 'http://www.runinmarseille.com/fr', limit_date: '2019-03-15')

race3 = Race.create!(name: 'Run in Marseille ', date:'2019-02-24' , distance: 10000, address: 'Bouches du Rhône, 13002 Marseille', city: 'Marseille',
	url: 'http://www.runinmarseille.com/fr', limit_date: '2019-02-15')

race4 = Race.create!(name: 'Run in Marseille', date:'2019-01-24' , distance: 10000, address: 'Bouches du Rhône, 13002 Marseille', city: 'Marseille',
	url: 'http://www.runinmarseille.com/fr', limit_date: '2019-01-15')

race5 = Race.create!(name: 'Marathon du Golfe de Saint-Tropez' , date:'2019-03-31' , distance: 42195, address: '83120, Sainte-Maxime', city: 'Sainte-Maxime',
	url: 'http://www.marathondugolfedesainttropez.com/fr/participer/s-inscrire.htm', limit_date: '2019-04-15')

race6 = Race.create!(name: 'Semi-marathon de Saint-Troppez', date:'2019-02-24' , distance: 21097, address: '83120, Sainte-Maxime', city: 'Sainte-Maxime',
	url: 'http://www.marathondugolfedesainttropez.com/fr/participer/s-inscrire.htm', limit_date: '2019-03-15')

race7 = Race.create!(name: 'Run in Hyères', date:'2019-01-24' , distance: 10000, address: '83400, Hyères', city: 'Hyères',
	url: 'yeres-athle.fr/?page_id=108', limit_date: '2019-01-15')

race8 = Race.create!(name: 'Christmas Run', date:'2018-12-15' , distance: 10000, address: '83240, Cavalaire-sur-Mer', city: 'Cavalaire-sur-Mer',
	url: 'http://www.christmasrun.fr/', limit_date: '2018-12-10')

race9 = Race.create!(name: 'Marathon des vins de Blaye ', date:'2019-05-24' , distance: 42195, address: '33390, Blaye', city: 'Blaye',
	url: 'http://www.marathondesvinsdeblaye.com/', limit_date: '2019-05-15')

race10 = Race.create!(name: 'Foulées saint selvaises', date:'2019-04-24' , distance: 21097, address: '33650, Saint-Selve', city: 'Saint-Selve',
	url: 'https://www.fouleesstselvaises.com/', limit_date: '2019-04-15')

race11 = Race.create!(name: 'Rando 10 Km', date:'2019-03-24' , distance: 10000, address: '33650, Saint-Selve', city: 'Saint-Selve',
	url: 'https://www.fouleesstselvaises.com/', limit_date: '2019-03-15')

race12 = Race.create!(name: 'Courir pour le plaisir', date:'2019-02-24' , distance: 10000, address: '33680, Le Porge', city: 'Le Porge',
	url: 'http://www.courirpourleplaisir.net/', limit_date: '2019-02-15')

puts "Races Created"

#Objective
objective1 = Objective.create!(user: user1, race: race1, kind: 'Marathon' , duration: 4, distance: 42195, status: 'pending'  )

puts "Objectives Created"

#Runs
run1 = Run.create!(objective: objective1, race: race4, targeted_time: 3300, status: 'pending')
run2 = Run.create!(objective: objective1, race: race3, targeted_time: 3000, status: 'pending')
run3 = Run.create!(objective: objective1, race: race2, targeted_time: 7620, status: 'pending')
run4 = Run.create!(objective: objective1, race: race1, targeted_time: 14400, status: 'pending')

puts "Runs Created"

#Training Plan

training_plan1 = TrainingPlan.create!(name: 'préparer à courir un marathon' , sessions_per_week: 3)

puts "Training Plans Created"

#Training Sessions

	#Week 1
session1 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 5 à 12 Km', position: 1)
session2 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 3 à 8 km', position: 2)
session3 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 10 Km', position: 3)

	#Week 2
session4 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 5 à 12 km', position: 4)
session5 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 3 à 8 Km', position: 5)
session6 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 13 km', position: 6)

	#Week 3
session7 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 5 à 12 Km', position: 7)
session8 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 3 à 8 km', position: 8)
session9 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 10 Km', position: 9)

	#week 4
session10 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 5 à 12 km', position: 10)
session11 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 3 à 8 km', position: 11)
session12 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 16 km', position: 12)

	#Week 5
session13 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 5 à 12 Km', position: 13)
session14 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 3 à 8 km', position: 14)
session15 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 13 Km', position: 15)

	#Week 6
session16 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 5 à 12 km', position: 16)
session17 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 3 à 8 Km', position: 17)
session18 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 16 km', position: 18)

	#Week 7
session19 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 5 à 12 Km', position: 19)
session20 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 3 à 8 km', position: 20)
session21 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 19 Km', position: 21)

	#week 8
session22 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 5 à 12 km', position: 22)
session23 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 3 à 8 km', position: 23)
session24 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 22.5 km', position: 24)

	#Week 9
session25 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 5 à 12 Km', position: 25)
session26 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 3 à 8 km', position: 26)
session27 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 22.5 Km', position: 27)

	#Week 10
session28 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 5 à 12 km', position: 28)
session29 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 3 à 8 Km', position: 29)
session30 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 29 km', position: 30)

	#Week 11
session31 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 5 à 12 Km', position: 31)
session32 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 3 à 8 km', position: 32)
session33 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 22.5 Km', position: 33)

	#week 12
session34 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 5 à 12 km', position: 34)
session35 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 3 à 8 km', position: 35)
session36 = TrainingSession.create!(training_plan: training_plan1, description: 'courir 29 km', position: 36)

puts "Training Sessions Created"

#Trainings

training = Training.create!(user: user1, training_plan: training_plan1, begin_date: '2019-01-06')

puts "Training Created"

puts "Finished"

