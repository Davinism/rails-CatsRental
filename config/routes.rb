Rails.application.routes.draw do
  resources :cats

  resources :cat_rental_requests do
    patch "approve", on: :collection
    patch "deny", on: :collection
  end

  # resources :cats do
  #   resources :cat_rental_requests, only: :index
  # end

end
