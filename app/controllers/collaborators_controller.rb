class CollaboratorsController < ApplicationController

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.build(collaborator_params)
    if @collaborator.save
      flash[:notice] = "You Added a collaborator"
    else
      flash[:alert] = "Was not about to add collaborator. Please try again"
    end
    redirect_to wiki_path(@wiki)
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
      if @collaborator.destroy
       flash[:notice] = "You removed the collaborator."
     else
       flash[:alert] = "You did not remove the collaborator."
     end
   redirect_to wiki_path(@collaborator.wiki)
 end
  private

  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end
end
