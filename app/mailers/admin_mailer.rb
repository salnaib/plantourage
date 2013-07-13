class AdminMailer < ActionMailer::Base
  default from: "plantourage@gmail.com"
  defailt to: "plantourage@gmail.com"

  def plan_created(plan, user)
    @user = user
    @plan = plan
    mail(:subject => "Plan Created")
  end
end
