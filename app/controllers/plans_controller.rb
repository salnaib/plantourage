class PlansController < ApplicationController

  # GET /plans
  # GET /plans.json
  def index
    @plans = Plan.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plans }
    end
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    @plan = Plan.find(params[:id])
    @invites = @plan.invites.all
    @microposts = @plan.microposts.all
    @suggestions = @plan.suggestions.all.sort_by { |obj| - obj.pointcount }

    @venues = Venue.all.sort_by{ |obj| obj['name'] }

    @graph  = Koala::Facebook::API.new(session[:access_token])
    # Get public details of current application
    @app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])

    @friends = @graph.get_connections('me', 'friends').sort_by { |obj| obj['name'] }

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plan }
    end
  end

  # GET /plans/new
  # GET /plans/new.json
  def new
    @plan = Plan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plan }
    end
  end

  # GET /plans/1/edit
  def edit
    @plan = Plan.find(params[:id])
  end

  # POST /plans
  # POST /plans.json
  def create

    @plan = Plan.new(params[:plan])
    @plan['name'] = params[:name]
    @plan['plandate'] = params[:plandate]

    @plan.save

    @invite = Invite.new
    @invite.plan = @plan
    @invite['user_id'] = params[:userid]

    @invite.save

  end

  # PUT /plans/1
  # PUT /plans/1.json
  def update
    @plan = Plan.find(params[:id])

    respond_to do |format|
      if @plan.update_attributes(params[:plan])
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy

    respond_to do |format|
      format.html { redirect_to plans_url }
      format.json { head :no_content }
    end
  end

end
