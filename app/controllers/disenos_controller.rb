class DisenosController < ApplicationController
  def index
    @disenos = Diseno.search(params[:search],:match_mode => :any) if params[:search]
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
  end
  
  def update
    @diseno = Diseno.find(params[:id])
    if @diseno.update_attributes(params[:diseno])
      flash[:notice] = "Successfully updated..." 
      redirect_to diseno_path(params[:id])
    else
      flash[:notice] = "Not updated"
      render :edit
    end
  end
  
  def create
    @diseno = Diseno.new(params[:diseno])
    if @diseno.save
      flash[:notice] = "Successfully created..."
      redirect_to(diseno_path(@diseno))
    else
      flash[:error] = "not created"
      render :new
    end
  end
end
