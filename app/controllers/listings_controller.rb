class ListingsController < ApplicationController
  
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  #make sure the user is logged in to edit, delete or create
  before_action :logged_in_user, only: [:edit, :create, :destroy, :update]
  #make sure the person editing/deleting is the owner
  before_action :correct_user, only: [:edit,:destroy, :update]
  
  # GET /listings
  # GET /listings.json
  
  def index
    @listings = Listing.all
    #@query = Listing.search do
   #     fulltext params[:query]
   #end
  #@listings = @query.results
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end
  
  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    #Possibly have the wrong functionality here, need to check database
    #corrected functionality!
    @listing.user_id = current_user.id
    
      require "stripe"
      Stripe.api_key = ENV["STRIPE_API_KEY"]
      token = params[:stripeToken]

      recipient = Stripe::Recipient.create(
        :name => current_user.first_name + " " + current_user.last_name,
        :type => "individual",
        :bank_account => token
        )

      current_user.recipient = recipient.id
      current_user.save
    
    respond_to do |format|
      if @listing.save
        format.html { redirect_to user_path(current_user), notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to user_path(current_user), notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:name, :description, :languages, :job_type, :projects, :price, :posthire)
    end
    
    # Use to owner is editing or deleting
    def correct_user
      is_owner?(@listing)
    end
    
end
