Rails.application.routes.draw do
   namespace :api do
  	    namespace :v1 do
  		    resources :events do
  			  resources :users do
  		    end
  		end 
  	 end
    end 
end
