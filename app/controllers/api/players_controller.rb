class Api::PlayersController < ApplicationController
  def index
  end

  def show
  end

  def create
    @player = Player.new(player_params.except(:playerSkills))
    player_skills_params = player_params[:playerSkills]

    if @player.save && valid_skills?(player_skills_params)
      create_player_skills(player_skills_params)
      render json: @player, status: :created
    else
      @player.errors.add(:skill, 'is not a valid skill')
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def player_params
    params.except(:player).permit(:id, :name, :position, playerSkills: [:skill, :value])
  end

  def create_player_skills(player_skills_params)
    player_skills_params.each do |skill_params|
      @player.player_skills.create(skill_params)
    end
  end

  def valid_skills?(player_skills_params)
    player_skills_params.all? do |skill_params|
      PlayerSkill::AVAILABLE_SKILLS.include?(skill_params[:skill])
    end
  end
end