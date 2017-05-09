class AlbumsController < ApplicationController
  load_and_authorize_resource
  
  def create
    album = Album.new params[:album]
    album.user = current_user
    if album.save
      flash[:notice] = "Cadastro efetuado com sucesso!"
      redirect_to :action=>'index'
    else
      flash[:alert] = params[:errors]
      redirect_to :action=>'new'
    end
    
  end
  
end
