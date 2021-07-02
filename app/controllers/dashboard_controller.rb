class DashboardController < ApplicationController
  skip_before_action :has_info

  def home
    @user = current_user

    # See if the user has a font preference
    if params[:font]
      cookies[:font] = params[:font]
    end

    if (@user.id != session[:user_id])
      flash[:success] = "CTF[PowerLevelIntegerOverflow]"
    end
  end

  def change_graph
    self.try(params[:graph])
  end

  def bar_graph
    render :partial => "layouts/dashboard/bar_graph"
  end

  def pie_charts
     @user = current_user
     render :partial => "layouts/dashboard/dashboard_stats"
  end

end
