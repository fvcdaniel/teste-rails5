class HomeController < ApplicationController
  #before_filter check_authorization
  helper_method :sort_column, :sort_direction 
  
  def home 
    #authorize! :read, @home
    if(params[:search])
      @musicas = Musica.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page=>10, :page=> params[:page])
    else
      @musicas = Musica.order(sort_column + " " + sort_direction).paginate(:per_page=>10, :page=> params[:page])
    end
    puts YAML::dump(@musicas)
  end
  
  private
  
  def sort_column
    Musica.column_names.include?(params[:sort]) ? params[:sort] : "nome"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
