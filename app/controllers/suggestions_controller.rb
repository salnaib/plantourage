
class SuggestionsController < ApplicationController

  before_filter :admin_user, only: [:show, :index, :new, :edit, :update, :destroy ]

  # GET /suggestions
  # GET /suggestions.json
  def index
    @suggestions = Suggestion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @suggestions }
    end
  end

  # GET /suggestions/1
  # GET /suggestions/1.json
  def show
    @suggestion = Suggestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @suggestion }
    end
  end

  # GET /suggestions/new
  # GET /suggestions/new.json
  def new
    @suggestion = Suggestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @suggestion }
    end
  end

  # GET /suggestions/1/edit
  def edit
    @suggestion = Suggestion.find(params[:id])
  end

  # POST /suggestions
  # POST /suggestions.json
  def create
    @venue = Venue.find_by_google_id(params['venuegoogleid'])
    if (@venue.nil?)
      @venue = Venue.new

      @venue.google_id = params['venuegoogleid']
      @venue.name = params['venuename']
      @venue.address = params['venueaddress']
      @venue.city = params['venuecity']
      @venue.state = params['venuestate']
      @venue.country = params['venuecountry']
      @venue.postal = params['venuepostal']
      @venue.phone = params['venuephone']
      @venue.googleurl = params['venuegoogleurl']
      @venue.website = params['venuewebsite']
      @venue.geolocation = params['venuegeolocation']
      @venue.venue_type = params['venuetypes']

      @venue.save
    end

    if (Suggestion.find_by_venue_id_and_plan_id(@venue.id, params['plan_id']).nil?)
      @suggestion = Suggestion.new(params[:suggestion])
      @suggestion.plan_id = params['plan_id']
      @suggestion.venue_id = @venue.id

      @suggestion.save
    end

  end

  # PUT /suggestions/1
  # PUT /suggestions/1.json
  def update
    @suggestion = Suggestion.find(params[:id])

    respond_to do |format|
      if @suggestion.update_attributes(params[:suggestion])
        format.html { redirect_to @suggestion, notice: 'Suggestion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suggestions/1
  # DELETE /suggestions/1.json
  def destroy
    @suggestion = Suggestion.find(params[:id])
    @suggestion.destroy

    respond_to do |format|
      format.html { redirect_to suggestions_url }
      format.json { head :no_content }
    end
  end

  protected

  def authorized_user
    if (session[:user_id].to_s == "")
      redirect_to '/unauthorized'
    end
  end

  def admin_user
    redirect_to '/unauthorized'
  end

end
