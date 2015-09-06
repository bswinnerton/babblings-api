FactoryGirl.define do
  factory :image do
    sequence(:remote_source_url) do |n|
      "http://i.imgur.com/p12QuhU.jpg?test_id=#{n}"
    end

    sequence(:origin) do |n|
      "http://i.imgur.com/p12QuhU.jpg?test_id=#{n}"
    end
  end
end
