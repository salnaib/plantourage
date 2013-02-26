class MicropostsController < ApplicationController


  def addcomment

    @micropost = Micropost.new(params[:micropost])
    @micropost['content'] = params['content']
    @micropost['plan_id'] = params['plan_id']
    @micropost['invite_id'] = params['invite_id']

    @micropost.save

  end

  def deletecomment

    @micropost = Micropost.find(params['comment_id'])

    @micropost.destroy

  end

  protected

  def authorized_user
    if (session[:user_id].to_s == "")
      redirect_to '/unauthorized'
    end
  end


end