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
        #player 1 attacks
        attack(player1, player2)
        #check survivor
        break if player2.character.life <= 0
        # player 2 attacks
        attack(player2, player1)

      end
      player1.win = player2.character.life <= 0
      player2.win = !player1.win

      if player1.win
        add_log(@fight, " #{player1.character.name } win ")
      else
        add_log(@fight, " #{player2.character.name } win ")
      end
      player1.save
      player2.save

      redirect_to fight_path(@fight)
    else
      render :new
    end
  end

  private

  def evade?(player)
    rand < player.character.speed/100.0
  end

  def add_log(fight, move_description)
    log = FightLog.new()
    log.fight = fight
    log.move_description = move_description
    log.save
  end

  def attack(player1, player2)
    if evade?(player2)
      add_log(@fight, " #{player2.character.name } evaded from  #{player1.character.name} attack ")
    else
      if player2.shield.power > 0
        player2.shield.power -= (player1.character.attack + player1.weapon.power) / 10
        add_log(@fight,  " #{player2.character.name } blocked attack from #{player1.character.name } with #{player2.shield.name} shield ")
      else
        player2.character.life -= (player1.character.attack + player1.weapon.power) / 10
        add_log(@fight, " #{player1.character.name } impact #{(player1.character.attack + player1.weapon.power) / 10} damage to #{player2.character.name }")
      end
    end
  end

  def fight_params
    params.require(:fight).permit(players_attributes: [:id, :character_id, :weapon_id, :shield_id])
  end
end
