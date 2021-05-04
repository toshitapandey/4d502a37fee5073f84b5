module Api
  class UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy ]

    # GET /users or /users.json
    def index
      users = User.all
    end

    # GET /users/1 or /users/1.json
    def show
      user = User.find_by(id: params[:id])
      format.json { render :show, status: :created, location: user }
    end

    # POST /users or /users.json
    def create
      @user = User.new(user_params)

      respond_to do |format|
        if @user.save
          format.json { render :show, status: :created, location: @user }
        else
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /users/1 or /users/1.json
    def update
      respond_to do |format|
        if @user.update(user_params)
          format.json { render :show, status: :ok, location: @user }
        else
          format.json { render json: @user.errors, status: :unprocessable_entity }
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
