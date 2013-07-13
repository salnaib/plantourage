class PlansController < ApplicationController
  before_filter :authorized_user, only: [:show]
  before_filter :authorized_user_for_plan, only: [:show ]
  before_filter :admin_user, only: [:index, :new, :edit, :update, :destroy ]


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
    #@app  =  @graph.get_object(ENV["FACEBOOK_APP_ID"])

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
    if (params[:plandate].blank?)
      @plan['plandate'] = Date.today
    else
      @plan['plandate'] = params[:plandate]
    end

    @plan.save

    @invite = Invite.new
    @invite.plan = @plan
    @invite['user_id'] = params[:userid]

    @invite.save

    UserMailer.plan_created(@plan, @user).deliver

  end

  def createEvent
    @plan = @plan = Plan.find(params[:id])
    @graph  = Koala::Facebook::API.new(session[:access_token])

    @plan.invites.each do |invite|
      users = users + invite.user.uid + ','
    end

    params = {
        :name => @plan.name,
        #:start_time => @plan.plandate,
        :end_time => @plan.plandate + 1,
        #:location => 'TBD on <a href = "plantourage.herokuapp.com/"' +@plan.fbevent_id+'">Plantourage</a>',
        #:privacy_type => 'SECRET'
    }

    @plan['FbEvent_id'] = @graph.put_object('me', 'events', params )
    @plan.save



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

  def change
    @plan = Plan.find(params[:id])

    @plan['name'] = params[:plan_name]
    if !(params[:plan_date].blank?)
      @plan['plandate'] = params[:plan_date]
    end

    @plan.save

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

  protected

  def authorized_user
    if (session[:user_id].to_s == "")
      redirect_to '/unauthorized'
    end
  end

  def authorized_user_for_plan
    @invite = Invite.find_by_user_id_and_plan_id(session[:user_id], params[:id])

    if (@invite.nil?)
      redirect_to '/unauthorized'
    end

  end

  def admin_user
    redirect_to '/unauthorized'
  end


end
