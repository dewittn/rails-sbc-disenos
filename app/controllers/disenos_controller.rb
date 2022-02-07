class DisenosController < ApplicationController
  cache_sweeper :diseno_sweeper, :only => [:update, :destory]
  caches_page :index, :new, :show, :if => Proc.new { |c| !c.request.format.js? }
  
  def index
    expires_in 1.hour unless request.format.js?
    @letters = Letter.all unless params[:search]
    begin
      @disenos = Diseno.search(params[:search],:match_mode => :any) if params[:search]
    rescue
      render :partial => 'search_error'#, :status => 500 if params[:search]
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
    fresh_when(:etag => @diseno)
  end
  
  def update
    @diseno = Diseno.find(params[:id])
    if @diseno.update_attributes(params[:diseno])
      flash[:notice] = t('design.flash.updated') 
      render :show
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
    else
      flash[:error] = t('design.flash.not_updated') 
      render :new
    end
  end
end
