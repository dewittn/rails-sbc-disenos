class ColoresController < ApplicationController
  cache_sweeper :color_sweeper, :only => [:update, :create, :destory]
  caches_page :index
  
  def index
    @colores = Color.find(:all)
  end
  
  def edit
    @color = Color.find(params[:id])
    render :new
  end
  
  def update
    if Color.update(params[:id],params[:color])
      flash[:notice] = t('color.flash.updated') #{}"Color saved"
      redirect_to colores_path
    else
      flash[:error] = t('color.flash.not_updated') #{}"Color not saved"
    end
  end
  
  def new
    @color = Color.new
  end
  
  def create
    @color = Color.new(params[:color])
    if @color.save
      flash[:notice] = t('color.flash.created') #{}"Color created"
      redirect_to colores_path
    else
      flash[:error] = t('design.flash.not_created') #{}"Color not created"
      render :new
    end
  end
end
