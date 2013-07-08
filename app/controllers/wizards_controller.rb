class WizardsController < ApplicationController
  before_filter :authenticate_user

  def skills
    @skills = current_user.skills
    @tags = Tag.all.select { |tag| !tag.is_location? }
  end

  def locations
    @user = current_user
    @locations = Tag.all.select { |tag| tag.is_location? }
    @user_locs = current_user.locations
  end
end
