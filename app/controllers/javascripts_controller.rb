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
      @diseno.attributes = diseno_params if params[:diseno]
    else
      @diseno = Diseno.new(diseno_params) if params[:diseno]
    end
    @diseno.hilos.build
  end

  private

  def diseno_params
    params.require(:diseno).permit(
      :nombre_de_orden, :notas,
      :image, :original, :archivo_dst, :archivo_pes, :names,
      hilos_attributes: [:id, :color_id, :marca_id, :_destroy]
    )
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

  def path_prefix
    respond_to do |format|
      format.js { render template: 'vendor/plugins/coto_solutions/app/views/javascripts/path_prefix' }
    end
  end
end
