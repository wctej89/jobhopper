class WizardsController < ApplicationController
  before_filter :authenticate_user

  def skills
    cookies[:skills] = true
    @skills = current_user.skills
    @tags = Tag.all.select { |tag| !tag.is_location? }
  end

  def locations
    cookies[:skills] = false
    @user = current_user
    @locations = Tag.all.select { |tag| tag.is_location? }
    @user_locs = current_user.locations
  end
end
