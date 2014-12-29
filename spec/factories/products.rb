FactoryGirl.define do
  factory :product do
    name "Max Steel"
    description "Action man fake"
    published_ad "2014-11-11 15:14:41"
    image { fixture_file_upload 'spec/factories/images/g.jpg', 'image/jpg' }
  end
end
