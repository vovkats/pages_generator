FactoryGirl.define do

  factory :page, class: Page do

    sequence :name do |n|
      "name#{n}"
    end

    title Faker::Lorem.sentence
    content Faker::Lorem.paragraph
    root_id nil
    path { PathService.form_path(self) }
  end
end