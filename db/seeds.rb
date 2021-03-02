# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Account::Admin.create([
  {id: 1, email: ENV["TEST_ADMIN_EMAIL"], password: ENV["TEST_APP_PASSWORD"], password_confirmation: ENV["TEST_APP_PASSWORD"], role: "admin"}
  ])

Account::Admin.create([
  {id: 2, email: "sponsor@test.com", password: ENV["TEST_APP_PASSWORD"], password_confirmation: ENV["TEST_APP_PASSWORD"], role: "sponsor"}
  ])


Account::User.create([
  {id: 1, email: ENV["TEST_USER_EMAIL"], password: ENV["TEST_APP_PASSWORD"], password_confirmation: ENV["TEST_APP_PASSWORD"]}
  ])

SignUp::Conference.create([
  {id: 1,
    name: "2021春全国初中数学",
    full_name: "东师 “前沿课堂”大家谈（2021春）全国初中数学教学在线观摩研讨会",
    eng_name: "twenty_one_junior_high_math",
    start_date: "2021/4/6",
    finish_date: "2021/4/7"},
  {id: 2,
    name: "2021春全国初中语文",
    full_name: "东师 “前沿课堂”大家谈（2021春）全国初中语文教学在线观摩研讨会",
    eng_name: "twenty_one_junior_high_chinese",
    start_date: "2021/4/8",
    finish_date: "2021/4/9"},
  {id: 3,
    name: "2021春全国初中英语",
    full_name: "东师 “前沿课堂”大家谈（2021春）全国初中英语教学在线观摩研讨会",
    eng_name: "twenty_one_junior_high_english",
    start_date: "2021/4/10",
    finish_date: "2021/4/11"},
  {id: 4,
    name: "2021春全国小学数学",
    full_name: "东师 “前沿课堂”大家谈（2021春）全国小学数学教学在线观摩研讨会",
    eng_name: "twenty_one_primary_math",
    start_date: "2021/4/24",
    finish_date: "2021/4/25"},
  {id: 5,
    name: "2021春全国小学语文",
    full_name: "东师 “前沿课堂”大家谈（2021春）全国小学语文教学在线观摩研讨会",
    eng_name: "twenty_one_primary_chinese",
    start_date: "2021/5/7",
    finish_date: "2021/5/8"},
  {id: 6,
    name: "2021春全国小学英语",
    full_name: "东师 “前沿课堂”大家谈（2021春）全国小学英语教学在线观摩研讨会",
    eng_name: "twenty_one_primary_english",
    start_date: "2021/5/14",
    finish_date: "2021/5/15"}
  ])
