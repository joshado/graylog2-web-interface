class SettingsController < ApplicationController
  filter_access_to :index
  filter_access_to :store
  
  def index
  end

  def store
    Setting.delete_all(["user_id = ? and setting_type = ?", current_user.id, params[:setting_type]])
      
    setting = Setting.new
    setting.user_id = current_user.id
    setting.setting_type = params[:setting_type]
    setting.value = params[:value].to_i
    
    if setting.save
      flash[:notice] = "Setting has been saved!"
    else
      flash[:error] = "Could not edit setting."
    end

    redirect_to :action => "index"
  end
end
