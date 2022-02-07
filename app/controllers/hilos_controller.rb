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
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
