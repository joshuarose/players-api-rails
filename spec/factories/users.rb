FactoryBot.define do
  factory :user do
    first_name "Jim"
    last_name  "Bob"
    email "jim@bob.com"
    password "foobar123"
    password_confirmation "foobar123"
  end
  factory :user_two, class: User do
    first_name "Joe"
    last_name  "Bob"
    email "joe@bob.com"
    password "foobar123"
    password_confirmation "foobar123"
  end
end