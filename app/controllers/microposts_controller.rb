class MicropostsController < ApplicationController

  def addcomment

    @micropost = Micropost.new(params[:micropost])
    @micropost['content'] = params['content']
    @micropost['plan_id'] = params['plan_id']
    @micropost['invite_id'] = params['invite_id']

    @micropost.save

  end

end