include ActionDispatch::TestProcess

FactoryBot.define do
  factory :picture do
    file { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'ragnar.jpeg'), 'image/jpeg') }
    description {"derp derp"}
  end
end
