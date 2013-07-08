class UserTagsController < ApplicationController


  def create
    user = User.find(params["user_tags"]["user_id"].to_i)
    tags = params["user_tags"]["tags"]
    tags.each do |tag|
      user.user_tags.create(:tag_id => tag.to_i)
    end
    redirect_to :back
  end

  def destroy
    if current_user.id = params[:id]
      UserTag.find_by_tag_id_and_user_id(params[:id],current_user.id).destroy
    end
    render nothing: true
  end
end

