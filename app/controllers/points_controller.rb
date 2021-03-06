
class PointsController < ApplicationController

  before_filter :admin_user, only: [:show, :index, :new, :edit, :update, :destroy, :create ]

  # GET /points
  # GET /points.json
  def index
    @points = Point.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @points }
    end
  end

  # GET /points/1
  # GET /points/1.json
  def show
    @point = Point.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @point }
    end
  end

  # GET /points/new
  # GET /points/new.json
  def new
    @point = Point.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @point }
    end
  end

  # GET /points/1/edit
  def edit
    @point = Point.find(params[:id])
  end

  # POST /points
  # POST /points.json
  def create
    @point = Point.new(params[:point])

    respond_to do |format|
      if @point.save
        format.html { redirect_to @point, notice: 'Point was successfully created.' }
        format.json { render json: @point, status: :created, location: @point }
      else
        format.html { render action: "new" }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /points/1
  # PUT /points/1.json
  def update
    @point = Point.find(params[:id])

    respond_to do |format|
      if @point.update_attributes(params[:point])
        format.html { redirect_to @point, notice: 'Point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.json
  def destroy
    @point = Point.find(params[:id])
    @point.destroy

    respond_to do |format|
      format.html { redirect_to points_url }
      format.json { head :no_content }
    end
  end

  def addpoint
    @suggestion = Suggestion.find(params[:suggestion_id])
    @plan = @suggestion.plan
    @invite = @plan.invites.find_by_user_id(current_user['id'])
    #@point = Point.find_by_suggestion_id_and_invite_id(params[:suggestion_id],@invite.id)
    #if @point.nil?
      @point = Point.new
      @point.suggestion_id = params[:suggestion_id]
      @point.invite_id = @invite.id
      @point.plan_id = @plan.id
      @point.count = 1
    #else
    #  if @point.count < 10
    #    @point.count = @point.count + 1
    #  end
    #end
    @point.save!

  end

  def removepoint
    @suggestion = Suggestion.find(params[:suggestion_id])
    @plan = @suggestion.plan
    @invite = @plan.invites.find_by_user_id(current_user['id'])
    @point = Point.find_by_suggestion_id_and_invite_id(params[:suggestion_id],@invite.id)
    #if @point.nil?
    #  @point = Point.new
    #  @point.suggestion_id = params[:suggestion_id]
    #  @point.invite_id = @invite.id
    #  @point.plan_id = @plan.id
    #  @point.count = 0
    #else
    #  if @point.count > 0
    #    @point.count = @point.count - 1
    #  end
    #end
    #@point.save!

    @point.destroy

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
