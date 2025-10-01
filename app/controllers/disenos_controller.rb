class DisenosController < ApplicationController
  respond_to :thml, :js
  cache_sweeper :diseno_sweeper, :only => [:update, :destory]
  caches_page :index, :new, :show, :if => Proc.new { |c| !c.request.format.js? }
  
  def index
    expires_in 1.day unless request.format.js?
    @disenos = Diseno.where("nombre_de_orden LIKE ?", "%#{params[:search]}%" ) #search(params[:search],:match_mode => :any)
    @letters = Letter.all 
  end
  
  def new
    @diseno = Diseno.new()
    3.times { @diseno.hilos.build }
  end
  
  def edit
    @diseno = Diseno.includes(:hilos).find(params[:id])
  end
  
  def show
    @letters = Letter.all 
    @diseno = Diseno.find(params[:id])
    image_send if params[:image_send]
    # fresh_when(:etag => @diseno)
  end
  
  def update
    @diseno = Diseno.find(params[:id])
    if @diseno.update_attributes(diseno_params)
      flash[:notice] = t('design.flash.updated')
      render :show
      flash[:notice] = nil
    else
      flash[:notice] = t('design.flash.not_updated')
      render :edit
    end
  end

  def create
    @diseno = Diseno.new(diseno_params)
    if @diseno.save
      flash[:notice] = t('design.flash.created')
      render :show
      flash[:notice] = nil
    else
      flash[:error] = t('design.flash.not_created')
      render :new
    end
  end

  def destroy
    Diseno.destroy(params[:id])
    redirect_to(disenos_path)
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
