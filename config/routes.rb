Rails.application.routes.draw do
  resources :repositories, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'new'  => 'repositories#new', :as=>:new_repository
  get '/:technology' => 'browsers#category', :as=>:browser_technology
  get '/:technology/:category' => 'browsers#hierarchy', :as=>:browser_hierarchy
  get '/:technology/:category/:owner/:name' => 'browsers#repository', :as=>:browser_repository
  root 'browsers#technology'
end
