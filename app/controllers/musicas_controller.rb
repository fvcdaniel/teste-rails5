class MusicasController < ApplicationController
  load_and_authorize_resource
  
  def new
    @musica = Musica.new
  end
  def create
    musica = Musica.new params[:musica]
    album = Album.find(params[:musica][:album_id])
    unless album
      flash[:alert] = "Desculpe, nao conseguimos localizar o album especificado, se o problema persistir entre em contato pelo email: contato@midia-gospel.com. Obrigado."
      return redirect_to :action => 'new'
    end
    musica.album = album
    current_user.musicas << musica
    musica.save
    flash[:notice] = "Cadastro efetuado com sucesso!"# URL: " + @musica.arquivo.url
    redirect_to :action=>'new'
  end
  def show
    
  end
  def edit
    @musica = Musica.find params[:id]
  end
  def update
    musica = Musica.find params[:id]
    musica.update_attributes params[:musica]
    album = Album.find(params[:musica][:album_id])
    unless album
      flash[:alert] = "Desculpe, nao conseguimos localizar o album especificado, se o problema persistir entre em contato pelo email: contato@midia-gospel.com. Obrigado."
      return redirect_to :action => 'edit'
    end
    musica.album = album
    musica.save
    flash[:notice] = "Musica editada com sucesso!"
    redirect_to :action=>'index'
  end
  def destroy
    @musica = Musica.find(params[:id])
    @musica.arquivo.remove!
    @musica.delete
    flash[:notice] = "Musica excluida com sucesso!"
    redirect_to :action=>'index'
  end
  def index
    @musicas = current_user.musicas
  end
end
