ALLOW_DOTS ||= /[\w\-.:]+/

Tufts::Application.routes.draw do
  get 'advanced/facet' => 'advanced#facet', as: 'facet_advanced_search'

  concern :searchable, Blacklight::Routes::Searchable.new

  resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
    concerns :searchable
  end

  get 'downloads/:id(/:offset)', to: 'downloads#show', constraints: { id: ALLOW_DOTS, offset: /\d+/ }, as: 'download'

  resources :templates, only: [:index, :create, :destroy]
  unauthenticated do
    root to: 'contribute#redirect'
  end
  root to: "catalog#index", as: :authenticated_root
  resources :unpublished, only: [:index] do
    member do
      get 'facet'
    end
  end
  resources :deposit_types do
    get 'export', on: :collection
  end

  resources :contribute, as: 'contributions', :controller => :contribute, :only => [:index, :new, :create] do
    collection do
      get 'license'
    end
  end

  mount Hyrax::Engine => '/'
  post 'records/:id/publish', to: 'records#publish', as: 'publish_record', constraints: { id: ALLOW_DOTS }
  post 'records/:id/unpublish', to: 'records#unpublish', as: 'unpublish_record', constraints: { id: ALLOW_DOTS }
  post 'records/:id/revert', to: 'records#revert', as: 'revert_record', constraints: { id: ALLOW_DOTS }
  put 'records/:id/review', to: 'records#review', as: 'review_record', constraints: { id: ALLOW_DOTS }
  resources :records, only: [:destroy], constraints: { id: ALLOW_DOTS } do
    member do
      delete 'cancel'
    end
    resources :attachments, constraints: { id: ALLOW_DOTS }
  end

  resources :batches, only: [:index]
  namespace :batch do
    resources :xml_imports, only: [:new, :show, :create, :edit, :update]
    resources :template_updates, only: [:new, :show, :create]
    resources :template_imports, only: [:new, :show, :create, :edit, :update]
    resources :purges, only: [:new, :show, :create]
    resources :reverts, only: [:new, :show, :create]
    resources :publishes, only: [:new, :show, :create]
    resources :unpublishes, only: [:new, :show, :create]
    resources :metadata_imports, only: [:new, :show, :create]
    resources :exports, only: [:new, :show, :create] do
      get :download, on: :member
    end
  end

  namespace :handle do
    resources :logs, only: :index
  end

  mount Qa::Engine => '/qa'
  mount Blacklight::Engine => '/'

  resources :generics, only: [:edit, :update], constraints: { id: ALLOW_DOTS }

  devise_for :users

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  mount Hydra::RoleManagement::Engine => '/'
end
