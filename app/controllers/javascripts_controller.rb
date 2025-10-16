class JavascriptsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:timeline, :path_prefix]
  
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

  def timeline
    @events = TimelineEvent.includes(:subject).limit(10).order('created_at DESC').to_a
  end

  def email_image
    begin
      @diseno = Diseno.find(params[:id])
      UserMailer.email_design(@diseno, params[:email])
      @success = true
    rescue StandardError => e
      @success = false
    end
  end

  def show
    render :text => ""
  end

  def path_prefix
    render file: Rails.root.join('vendor', 'plugins', 'coto_solutions', 'app', 'views', 'javascripts', 'path_prefix.js.erb'), content_type: 'text/javascript'
  end

  private

  def diseno_params
    params.require(:diseno).permit(
      :nombre_de_orden, :notas,
      :image, :original, :archivo_dst, :archivo_pes, :names,
      hilos_attributes: [:id, :color_id, :marca_id, :_destroy]
    )
  end
end
