# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Clean Database
Player.delete_all
FightLog.delete_all
Fight.delete_all
Character.delete_all
Shield.delete_all
Weapon.delete_all

SHIELDS = ['Aegis', 'Ancilia', 'Shield of Achilles', 'Srivatsa', 'Wakandan City Shield', 'Buckler']
WEAPONS = ['Excalibur', 'Trident', 'Fragarach', 'Thunderbolt', 'Gungnir', 'Mjolnir']
CHARACTERS = ['Pikachu', 'Ronflex', 'Luigia', 'Mewto', 'Mew', 'Raiku', 'Suicune']


# Create shields
SHIELDS.each do |shield_name|
  Shield.create(name: shield_name, power: rand(1..100))
end


# Create weapons
WEAPONS.each do |weapon_name|
  Weapon.create(name: weapon_name, power: rand(1..100))
end


# Create Characters

CHARACTERS.each_with_index do |character_name, index|
  speed = rand(1..100)
  attack = rand(1..100)
  life = 200 - speed - attack
  new_character = Character.new(name: character_name, life: life, attack: attack, speed: speed)
  new_character.save!

end

# Simulate fights






