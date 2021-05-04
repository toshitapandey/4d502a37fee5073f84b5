module Api
  class UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy ]

    # GET /users or /users.json
    def index
      users = User.all
      valid_array = []
      users.each do |user|
        valid_array.push({
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email
        })
      end
      render json: valid_array, status: :ok
    end

    # GET /users/1 or /users/1.json
    def show
      user = User.find_by(id: params[:id])
      format.json { render json: user, status: :ok }
    end

    # POST /users or /users.json
    def create
      user = User.new(user_params)

      respond_to do |format|
        if user.save
          format.json { render json: user, status: :ok }
        else
          format.json { render json: user.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /users/1 or /users/1.json
    def update
      respond_to do |format|
        if user.update(user_params)
          format.json { render json: user, status: :ok }
        else
          format.json { render json: user.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /users/1 or /users/1.json
    def destroy
      @user.destroy
      respond_to do |format|
        format.json { head :no_content }
      end
    end

    # GET /api/typeahead/:input - depending on input, returns entry from users table. 
    # Searches with matches in strings in firstName, lastName, and email
    def typeahead
      input = params[:input]
      users = User.all
      valid_users = []
      users.each do |user|
        valid_users.push("#{user.firstName} #{user.lastName}")
      end
      format.json { render json: valid_users, status: :ok }
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:id, :firstName, :lastName, :email)
      end
  end
end
