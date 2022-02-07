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
  end

  def update
  end

  def destroy
  end

end
