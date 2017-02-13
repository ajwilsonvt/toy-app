class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # @user.microposts is never nil, even if user has 0 microposts, because it is an
    # ActiveRecord::Associations::CollectionProxy [] == empty array != nil
    # the following however, is nil with 0 microposts
    @first_micropost = @user.microposts.first

    if @first_micropost.nil?
      @first_micropost = "N/A"
    else
      # @first_micropost = @first_micropost.content would return a NoMethodError
      # because @first_micropost is a CollectionProxy, not a Micropost, and it
      # doesn't have a content method
      @first_micropost = @first_micropost.content 

      # @user.microposts == CollectionProxy
      # @user.microposts.content would return a NoMethodError because as a CollectionProxy,
      # not a Micropost, it doesn't have a content method
      # @user.microposts == Micropost, and it DOES have a content method
      # if you wanted to get the Microposts (and contents) from the CollectionProxy, use:
      # @user.microposts.find_by(user_id: @user.id).content
      # this only returns the 1st one because of [LIMIT, 1] in generated query
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
