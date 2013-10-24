# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    consented false
    survey = false
    token = "ASD"
    factory :consenting_user do
      consented true

      factory :consenting_control_user do
        control_group true
      end

      factory :consenting_game_user do
        control_group false
      end

      factory :conseting_survey_user do
        survey = false
      end
    end
  end
end