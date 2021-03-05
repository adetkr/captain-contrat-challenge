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
      player1.win = player2.character.life <= 0
      player2.win = !player1.win

      if player1.win
        log = FightLog.new()
        log.fight = player1.fight
        log.move_description = " #{player1.character.name } win "
        log.save
      else
        log = FightLog.new()
        log.fight = player1.fight
        log.move_description = " #{player2.character.name } win "
        log.save
      end
      player1.save
      player2.save

      redirect_to fight_path(@fight)
    else
      render :new
    end
  end

  private

  def attack(player1, player2)

    player2.character.life -= player1.character.attack / 10
    log = FightLog.new()
    log.fight = player1.fight
    log.move_description = " #{player1.character.name } impact #{player1.character.attack / 10} damage to #{player2.character.name }"
    log.save
  end

  def fight_params
    params.require(:fight).permit(players_attributes: [:id, :character_id])
  end
end
