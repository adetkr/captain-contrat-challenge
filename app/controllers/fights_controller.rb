class FightsController < ApplicationController
  def index
    @fights = Fight.all

  end

  def show
    @fight = Fight.find(params[:id])
  end

  def new
    @fight = Fight.new()
    @fight.players.build
    @fight.players.build
  end



  def create
    @fight = Fight.new(fight_params)
    if @fight.save
      # implement fight simulation
      player1 = @fight.players[0]
      player2 = @fight.players[1]

      while player1.character.life > 0
        # player 1 attacks
        attack(player1, player2)
        #check survivor
        break if player2.character.life <= 0
        # player 2 attacks
        attack(player2, player1)

      end

      if player2.character.life <= 0
        p " #{player1.character.name } win }"
      else
        p " #{player2.character.name } win }"
      end
      player1.save
      player2.save
      raise
      # update fight
      redirect_to fight_path(@fight)
    else
      render :new
    end
  end

  private

  def attack(player1, player2)

    player2.character.life -= player1.character.attack / 10
    p " #{player1.character.name } impact #{player1.character.attack / 10} damage to #{player2.character.name }"
  end

  def fight_params
    params.require(:fight).permit(players_attributes: [:id, :character_id])
  end
end
