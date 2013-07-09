class UserTagsController < ApplicationController


  def create
    cookies[:skills] = "true"
    user = current_user
    tag = params[:id]
    if tag
      user.user_tags.create(:tag_id => tag.to_i)
    end
    if cookies[:skills] == "true"
      redirect_to wizard_location_path
    else
      redirect_to user_feed_path(current_user)
    end
  end

  def destroy
    if current_user.id = params[:id]
      UserTag.find_by_tag_id_and_user_id(params[:id],current_user.id).destroy
    end
    render nothing: true
  end
end