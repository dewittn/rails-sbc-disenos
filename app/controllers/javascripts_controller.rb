class JavascriptsController < ApplicationController
  def colores
    unless params[:cantidad].blank?
      @diseno = Diseno.new
      params[:cantidad].to_i.times { @diseno.hilos.build } 
    end
  end
  
  def edit_colores
    @diseno = Diseno.find(params[:id])
    @diseno.hilos.build 
    render :colores
  end
  
  def dynamic_colores
    @colores = Color.find(:all)
  end
  
  def add_colors
    if params[:id]
      @marca = Marca.find(params[:id]) 
      @marca.attributes = params[:marca]
    else
      Marca.new(params[:marca])
    end
    @marca.colors.build
  end
  
  def timeline
    @events = TimelineEvent.all(:limit => 10, :order => 'created_at DESC', :include => :subject)
    render :update do |page| 
      page[:timeline].replace_html :partial => 'timeline'
    end
  end
end
