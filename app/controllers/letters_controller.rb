class LettersController < ApplicationController
  def show
    @letter = Letter.find(params[:id])
    @letters = Letter.all
  end
end
