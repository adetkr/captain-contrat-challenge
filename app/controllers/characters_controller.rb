class CharactersController < ApplicationController
  def new
    @character = Character.new()
  end

  def create
    @character = Character.new(params_character)

    if @character.save
      redirect_to characters_path
    else
      render :new
    end
  end

  def index
    @characters = Character.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_character
    @character = Character.find(params[:id])
  end

  def params_character
    params.require(:character).permit(:name, :life, :attack, :photo)
  end
end
