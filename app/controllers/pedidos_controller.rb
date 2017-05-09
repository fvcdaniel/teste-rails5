# encoding: utf-8
class PedidosController < ApplicationController
  include ApplicationHelper
  before_filter :login, :only => [:comprar]
  before_filter :musica, :only => [:comprar]
  skip_before_filter :verify_authenticity_token
  
  
  def index
    @pedidos = current_user.pedidos
  end
  def efetuado
    if request.get?
      if session[:pedido]
        @pedido = Pedido.find(session[:pedido])
      end
    else
      if request.post?
        pagseguro_notification do |notification|
          if notification.valid?
            @pedido = Pedido.find(notification.mapping_for(:order_id))
            @pedido.status = notification.mapping_for(:status)
            @pedido.musica.increment!(:download)
            @pedido.save
          end
          
        end
        render :nothing => true
      end
    end
  end
  
  def musica
    puts params[:musica_id] + " teste de id de musica"
    musica_not_found = "Música não encontrada! ;( Verifique a pesquisa e tente novamente."
    if params[:musica_id].blank?
      flash[:alert] = musica_not_found + "1"
      return redirect_to :back
    else
      unless is_numeric?(params[:musica_id])
        flash[:alert] = musica_not_found + "2"
        return redirect_to :back
      end 
    end
  end
  
  def login
    unless user_signed_in? 
      flash[:alert] = "É necessário fazer o login primeiro! Se não possui, faça o cadastro!"
      return redirect_to :back
    end
  end  
    
  def comprar
    musica = params[:musica_id].to_i
    @musica = Musica.find(musica)
    pedido = Pedido.new
    pedido.user = current_user
    pedido.musica = @musica
    pedido.dt_pedido = Date.today
    pedido.status = "Pendente"
    pedido.preco = 3 #mudar isto depois
    pedido.descricao = @musica.nome #mudar isto depois para descricao da musica, criar o campo no model
    pedido.save
    session[:pedido] = pedido.id
    return redirect_to :controller => "pedidos", :action => "show", :id => pedido.id
  end
  def show
    if params[:id].blank?
      if session[:pedido]
        @pedido = Pedido.find(session[:pedido])
        # Instanciando o objeto para geracao do formulario
        @order = PagSeguro::Order.new(@pedido.id)
        #precisa ajeitar para poder comprar mais de uma música
        @order.add :id => @pedido.musica.id, :price => @pedido.preco, :description => @pedido.descricao
    
        # adicionando os produtos do pedido ao objeto do formulario
        #@invoice.products.each do |product|
          # Estes sao os atributos necessarios. Por padrao, peso (:weight) eh definido para 0,
          # quantidade eh definido como 1 e frete (:shipping) eh definido como 0.
        #  @order.add :id => product.id, :price => product.price, :description => product.title
        #end
      else
        flash[:alert] = 'Ocorreu um erro estranho! Se o problema persistir reporte-o ao email: contato@midia-gospel.com'
        return redirect_to :back
      end
    else
      id = params[:id]
      if is_numeric?(id)
        @pedido = Pedido.find(id)
        @order = PagSeguro::Order.new(@pedido.id)
        @order.add :id => @pedido.musica.id, :price => @pedido.preco, :description => @pedido.descricao
      else
        flash[:alert] = 'Ocorreu um erro estranho! O pedido não foi encontrado! Se o problema persistir reporte-o ao email: contato@midia-gospel.com'
        return redirect_to :back
      end
    end
    
  end
  def pedido
    if session[:pedido]
      pedido = Pedido.find(session[:pedido])
      # Instanciando o objeto para geracao do formulario
      @order = PagSeguro::Order.new(pedido.id)
      #precisa ajeitar para poder comprar mais de uma música
      @order.add :id => pedido.musica.id, :price => pedido.preco, :description => pedido.descricao
  
      # adicionando os produtos do pedido ao objeto do formulario
      #@invoice.products.each do |product|
        # Estes sao os atributos necessarios. Por padrao, peso (:weight) eh definido para 0,
        # quantidade eh definido como 1 e frete (:shipping) eh definido como 0.
      #  @order.add :id => product.id, :price => product.price, :description => product.title
      #end
    else
      render :controller => "home", :action => "home"
    end
  end
  
  def confirm
    puts 'teste de params 2'
    return unless request.post?
    #puts 'teste de params' + YAML::Dump(params)
    #@pedido = Pedido.find(params[:ID])
    puts 'pedido recebeu algo' + @pedido.id
    # Se voce receber pagamentos de contas diferentes, pode passar o
    # authenticity_token adequado como parametro para pagseguro_notification
    #account = Account.find(params[:seller_id])
    pagseguro_notification(account.authenticity_token) do |notification|
    end
    render :nothing => true
  end
end
