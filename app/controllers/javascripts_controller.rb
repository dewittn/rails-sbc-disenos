class JavascriptsController < ApplicationController
  respond_to :html, :js
  
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
  end
  
  def timeline
    @disenos = Diseno.limit(5).order('updated_at')
    render :partial => @disenos
  end
  
  def email_image
    begin
      @diseno = Diseno.find(params[:id])
      UserMailer.email_design(@diseno, params[:email])
      @success = true
    rescue
      @success = false
    end
  end
  
  def show
    render :text => ""
  end
end
