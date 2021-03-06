class WikisController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!
  def index
    @wikis = Kaminari.paginate_array(policy_scope(Wiki)).page(params[:page]).per(10)
  end

  def show
    @users = User.where("role = 1 OR role = 2") #Used for Collaborators Selection
     @wiki = wiki_params

     unless @wiki.private == false || current_user
       flash[:alert] = "You are not allowed to view private Wikis "
       redirect_to wikis_path
     end

  end

  def private
    @wikis = current_user.wikis.where(private:true).page(params[:page]).per(15)
  end

  def new
    @wiki = current_user.wikis.new
  end

  def create
    @wiki = current_user.wikis.new(wiki_permits)

    if @wiki.save
      flash[:notice] = 'Wiki saved successfully.'
      redirect_to @wiki
    else
      flash[:alert] = 'Wiki not saved. Title is too short or missing. Please try again.'
      render :new
    end
  end

  def edit
    @wiki = wiki_params
  end

  def update
    @wiki = wiki_params
    @wiki.assign_attributes(wiki_permits)

    if @wiki.save
      flash[:notice] = "Wiki has been updated successfully"
      redirect_to @wiki
    else
      flash[:alert] = "Wiki was unable to be updated pleace try again. "
      render :edit
    end
  end

  def destroy
    @wiki = wiki_params
    @user = current_user

    if @wiki.destroy
      flash[:notice] = "Wiki Completed"
      redirect_to wikis_path
    else
      flash[:alert] = "Wiki was unable to be marked completed "
    end
    redirect_to @wiki
  end

  private

  def wiki_params
    Wiki.find(params[:id])
  end
  def wiki_permits
    params.required(:wiki).permit(:title, :body, :private, :user_id)
  end
end
