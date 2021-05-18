class UsersController < ApplicationController
   
   before_action :authenticate_user!, :good_user
   
    def index
  end

  def show
    @user = User.find(current_user.id)
    

private

def good_user
  @user = User.find(params['id'])
  if current_user.id == @user.id
  else
    redirect_to root_path
    flash[:danger]= "Bien essayé petit malin ! ;P"
  end
end

end
end