# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Post.create(action: 1, feedText: 'test tweet', location: 'manda, chen, paris', 
						materials: 'blanket, napkin, water', url: 'google')
Post.create(action: 0, feedText: 'dsfdsf', location: 'manda', materials: 'food', url: '')
Post.create(action: 0, feedText: 'feed2', location: 'paris, chen', materials: 'food, water, covers', url: '')
Post.create(action: 1, feedText: 'feed3', location: 'manda, velachery, mudichur', materials: 'food, beds, books', url: '')
Post.create(action: 0, feedText: 'feed4', location: 'mudichur, kanchi', materials: 'food', url: '')