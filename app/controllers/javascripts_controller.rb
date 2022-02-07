class JavascriptsController < ApplicationController
  def colores
    unless params[:cantidad].blank?
      @diseno = Diseno.new
      params[:cantidad].to_i.times { @diseno.hilos.build } 
    end
  end
  
  def add_hilos
    if params[:id]
      @diseno = Diseno.find(params[:id])
      @diseno.attributes = params[:diseno]
    else
      @diseno = Diseno.new(params[:diseno])
    end
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
      @marca = Marca.new(params[:marca])
    end
    @marca.colors.build
  end
  
  def timeline
    @events = TimelineEvent.all(:limit => 10, :order => 'created_at DESC', :include => :subject)
    render :update do |page| 
      page[:timeline].replace_html :partial => 'timeline'
    end
  end
  
  def email_image
    begin
      @diseno = Diseno.find(params[:id])
      DisenoMailer.deliver_email_image(@diseno, params[:email])
      render :update do |page|
        page[:email].hide()
        page[:notice].replace_html t('email.success')
      end
    rescue
        render :update do |page|
          page[:email].hide()
          page[:error].replace_html t('email.failure')
        end
      end
  end
end
