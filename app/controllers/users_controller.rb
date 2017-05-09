# encoding: utf-8
class UsersController < ApplicationController
  include UsersHelper
  
  def new
  end
  
  def inscrever
    @inscritos = inscritos
  end
  def unsubscribe
    email = params[:email]
    if email.blank?
      flash[:alert]='Desculpe, não conseguimos localizar um email para desasocia-lo.'
      return redirect_to :action=>'inscrever'
    else
      subscriber = subscriber(email)
      if subscriber.blank?
        flash[:alert]='Desculpe, não conseguimos localizar a pessoa que está associada a este email.'
        return redirect_to :action=>'inscrever'
      else
        if (current_user == subscriber)
          user = User.find_by_email(email)
          if !user.musicas.blank?
            flash[:alert]='Desculpe, o usuário não pode ser desassociado devido a já ter musicas cadastradas!.'
            return redirect_to :action=>'inscrever'
          end
          user.unsubscribed_at = Date.today
          user.removeRole('ArtistUser')
          user.save
          flash[:notice]='Usuário desassociado com sucesso!.'
          return redirect_to :action=>'inscrever'
        else
          flash[:alert]='Desculpe, você não possui permissão para desassociar este usuário.'+subscriber.id.to_s
          return redirect_to :action=>'inscrever'
        end 
      end
    end
  end
  
  def subscribe
    email = params[:user][:email]
    user = User.where("email = '"+email+"'").first
    if user 
     ability = Ability.new(user)
     if ability.can?(:create, Musica.new)
       flash[:alert]='Desculpe, mas este usuário já possui permissão para cadastrar suas músicas.'
     else
       user.addRole('ArtistUser')
       user.invited_by = current_user.id
       user.invited_at = Date.today
       user.unsubscribed_at = nil
       user.save
       flash[:notice]='Usuário associado com sucesso!.'
     end 
    else
      flash[:alert]='Ocorreu um erro estranho, não conseguimos achar este usuário, se o problema persistir avise-nos através do email: contato@midia-gospel.com. Obrigado!'
    end
    return redirect_to :action=>'inscrever'
  end

end
