FactoryGirl.define do
  factory :vimeo_video do
    sequence(:source) do |n|
      "https://vimeo.com/63609012?test_id=#{n}"
    end
  end
end
