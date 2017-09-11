Rails.application.routes.draw do
  root 'application#index', as: :home

  scope '/admin' do
    resources :comments
    resources :articles do
      collection do
        post :import
      end
    end
  end

  devise_for :users

  get 'blog/:id' => 'application#singlearticle', as: :show_single_article
  post 'comment' => 'application#Comment', as: :article_comments
  # root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
