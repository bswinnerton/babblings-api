FactoryGirl.define do
  factory :youtube_video do
    sequence(:source) do |n|
      "https://www.youtube.com/watch?v=I6OXjnBIW-4?test_id=#{n}"
    end
  end
end
