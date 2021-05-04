Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    # GET /api/users - returns all users from users table
    get 'users' => 'users#index'

    # GET /api/user/:id - returns specific user from users table given id
    get 'user' => 'users#show'

    # POST /api/user - adds a new user to the users table
    post 'user' => 'users#update'

    # PUT /api/user/:id - updates specific user in users table
    put 'user' => 'users#update'

    # DELETE /api/user/:id - removes the specific user from users table with the given id
    delete 'user' => 'users#delete'

    # GET /api/typeahead/:input - depending on input, returns entry from users table. 
    # Searches with matches in strings in firstName, lastName, and email
    get 'typeahead' => 'users#search'
  end
end
