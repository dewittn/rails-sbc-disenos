class DisenosController < ApplicationController
  cache_sweeper :diseno_sweeper, :only => [:update, :destory]
  caches_page :index, :new, :show, :if => Proc.new { |c| !c.request.format.js? }
  
  def index
    expires_in 1.day unless request.format.js?
    if params[:search]
      begin
        @disenos = Diseno.search(params[:search],:match_mode => :any)
      rescue
        render :partial => 'search_error'
      end
    else
      @letters = Letter.all 
    end
  end
  
  def new
    @diseno = Diseno.new()
    3.times { @diseno.hilos.build }
  end
  
  def edit
    @diseno = Diseno.find(params[:id], :include => :hilos)
  end
  
  def show
    @diseno = Diseno.find(params[:id])
    image_send if params[:image_send]
    # fresh_when(:etag => @diseno)
  end
  
  def update
    @diseno = Diseno.find(params[:id])
    if @diseno.update_attributes(params[:diseno])
      flash[:notice] = t('design.flash.updated') 
      render :show
      flash[:notice] = nil
    else
      flash[:notice] = t('design.flash.not_updated') 
      render :edit
    end
  end
  
  def create
    @diseno = Diseno.new(params[:diseno])
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
end
