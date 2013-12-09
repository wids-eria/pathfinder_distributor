PathfinderDistributor::Application.routes.draw do
  devise_for :users

  get "distributor/index"
  get "consent/form"
  get "game" => "game#player"
  get 'preiat' => "game#pre_iat"
  get 'postiat' => "game#post_iat"
  get 'complete' => "game#complete"
  get 'survey' => "distributor#survey"

  get 'postsurvey' => "distributor#postsurvey"

  put "consent/consent"

  root :to => "distributor#index"
end
