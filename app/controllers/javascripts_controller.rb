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
  
  def show
    render :text => ""
  end
end
