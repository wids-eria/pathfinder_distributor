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

  get 'auth/:provider/callback' => 'session#from_oauth'
  get 'auth/failure' => 'session#failure'
  get 'users/new_user' => 'session#create'

  get 'login' => 'session#login'
  get 'guest' => 'session#create_guest'
  delete 'logout' => 'session#destroy'


  root :to => "distributor#index"
end
