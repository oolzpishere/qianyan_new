# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Account::Admin.create([
  {id: 1, email: ENV["TEST_ADMIN_EMAIL"], password: ENV["TEST_APP_PASSWORD"], password_confirmation: ENV["TEST_APP_PASSWORD"]}
  ])

Account::User.create([
  {id: 1, email: ENV["TEST_USER_EMAIL"], password: ENV["TEST_APP_PASSWORD"], password_confirmation: ENV["TEST_APP_PASSWORD"]}
  ])
