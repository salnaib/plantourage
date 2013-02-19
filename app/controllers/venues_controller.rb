
class VenuesController < ApplicationController

  before_filter :admin_user, only: [:show, :index, :new, :edit, :update, :destroy, :create ]

  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.all
    @plan = Plan.find(session[:planid])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @venues }
    end
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    @venue = Venue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @venue }
    end
  end

  # GET /venues/new
  # GET /venues/new.json
  def new
    @venue = Venue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @venue }
    end
  end

  # GET /venues/1/edit
  def edit

    @plan = Plan.find(session[:planid])
    @suggestion = Suggestion.find_by_venue_id(params[:id])
    if (@suggestion.nil?)
      @suggestion = Suggestion.create
      @suggestion.plan = @plan
      @suggestion.venue = Venue.find(params[:id])
      @suggestion.save!
    end


    redirect_to @plan

    #respond_to do |format|
    #  if @suggestion.save
    #    format.html { redirect_to @plan, notice: 'Plan was successfully created.' }
    #    format.json { render json: @plan, status: :created, location: @plan }
    #  else
    #    format.html { render action: "new" }
    #    format.json { render json: @plan.errors, status: :unprocessable_entity }
    #  end
    #end



    #@venue = Venue.find(params[:id])
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(params[:venue])

    respond_to do |format|
      if @venue.save
        format.html { redirect_to @venue, notice: 'Venue was successfully created.' }
        format.json { render json: @venue, status: :created, location: @venue }
      else
        format.html { render action: "new" }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /venues/1
  # PUT /venues/1.json
  def update
    @venue = Venue.find(params[:id])

    respond_to do |format|
      if @venue.update_attributes(params[:venue])
        format.html { redirect_to @venue, notice: 'Venue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy

    respond_to do |format|
      format.html { redirect_to venues_url }
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
