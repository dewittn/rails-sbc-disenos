class HilosController < ApplicationController
  def index
    @marcas = Marca.all
  end

  def new
    @marca = Marca.new()
    3.times { @marca.colors.build }
  end

  def create
    @marca = Marca.new(marca_params)
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
    if @marca.update_attributes(marca_params)
      flash[:notice] = t('thread.flash.updated')
      redirect_to(hilos_path)
    else
      flash[:error] = t('thread.flash.not_updated')
      render :new
    end
  end

  def destroy
    Marca.destroy(params[:id])
    redirect_to(hilos_path)
  end

  private

  def marca_params
    params.require(:marca).permit(
      :nombre,
      colors_attributes: [:id, :nombre, :codigo, :hex, :marca_id, :nuevo_marca, :_destroy]
    )
  end
end
