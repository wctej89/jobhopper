class UserTagsController < ApplicationController


  def create
    user = User.find(params["user_tags"]["user_id"].to_i)
    tags = params["user_tags"]["tags"]
    tags.each do |tag|
      user.user_tags.create(:tag_id => Tag.find(tag.to_i))
    end
  end

  def destroy
    UserTag.where(tag_id: 11 && user_id=1)[0].destroy
  end
end
