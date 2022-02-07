class ColoresController < ApplicationController
  cache_sweeper :color_sweeper, :only => [:update, :create, :destory]
  caches_page :index
  
  def index
    @colores = Color.find(:all)
  end
  
  def edit
    @color = Color.find(params[:id])
  end
  
  def update
    if Color.update(params[:id],params[:color])
      flash[:notice]="Color saved"
      redirect_to colores_path
    else
      flash[:error]="Color not saved"
    end
  end
  
  def new
    @color = Color.new
  end
  
  def create
    @color = Color.new(params[:color])
    if @color.save
      flash[:notice]="Color created"
      redirect_to colores_path
    else
      flash[:error]="Color not created"
    end
  end
end
