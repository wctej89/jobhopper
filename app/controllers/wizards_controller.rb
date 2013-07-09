class WizardsController < ApplicationController
  before_filter :authenticate_user

  def skills
    @skills = current_user.skills
    # @tags = Tag.all.select { |tag| !tag.is_location? }
    @tags = Tag.limit(10)
  end

  def locations
    cookies[:skills] = false
    cookies[:new_user] = false
    @user = current_user
    @locations = Tag.all.select { |tag| tag.is_location? }
    @user_locs = current_user.locations
  end
end
