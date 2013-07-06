class WizardsController < ApplicationController

  def skills
    @skills = current_user.tags
    @tags = Tag.all.reject { |tag| current_user.tags.include?(tag) }
  end

  def locations
    @locations = Tag.all.reject {|tag| !tag.is_location? }
    @user_locs = current_user.tags.where('tag_type =?', 'LocationTag')
  end
end
