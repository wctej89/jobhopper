class WizardsController < ApplicationController

  def skills
    @skills = current_user.tags
    @tags = Tag.all.reject { |tag| current_user.tags.include?(tag) }
  end

  def locations
    @locations = current_user.locations
  end
end
