class HilosController < ApplicationController
  def index
    @marcas = Marca.all
  end

  def show
  end

  def new
    @marca = Marca.new()
    3.times { @marca.colors.build }
  end

  def create
    @marca = Marca.new(params[:marca])
    if @marca.save
      flash[:notice] = t('thread.flash.created')
      redirect_to(hilos_path)
    else
      flash[:error] = t('thread.flash.not_created')
      render :new
    end
  end

  def edit
    @marca = Marca.find(params[:id])
    render :new
  end

  def update
    @marca = Marca.find(params[:id])
    if @marca.update_attributes(params[:marca])
      flash[:notice] = t('thread.flash.updated')
      redirect_to(hilos_path)
    else
      flash[:error] = t('thread.flash.not_updated')
    end
  end

  def destroy
  end

end
