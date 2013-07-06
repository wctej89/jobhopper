class UserTagsController < ApplicationController


  def create
    user = User.find(params["user_tags"]["user_id"].to_i)
    tags = params["user_tags"]["tags"]
    tags.each do |tag|
      user.user_tags.create(:tag_id => Tag.find(tag.to_i))
    end
  end

  def destroy
    user = current_user
    
  end
end
