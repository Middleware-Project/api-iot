# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

sensor1 = Sensor.create(:name => 'humidity', :description => 'sensor de humedad', :units => '%')
sensor2 = Sensor.create(:name => 'temperature', :description => 'sensor de temperatura', :units => 'Cº')
group = Group.create(:name => 'Salon principal', :description => 'Salon ubicado en el perimer piso')
@node = Node.new(:modelName => 'pysense', :manufacterName => 'pycom', :description => 'sensor')
@node.group = group
@node.sensors << sensor1
@node.sensors << sensor2
@node.save
