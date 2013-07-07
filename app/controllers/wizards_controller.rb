class WizardsController < ApplicationController

  def skills
    @skills = current_user.skills
    @tags = Tag.limit(10)
  end

  def locations
    @locations = Tag.all.select { |tag| tag.is_location? }
    @user_locs = current_user.locations
  end
end
