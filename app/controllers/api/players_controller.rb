class Api::PlayersController < ApplicationController
  before_action :authorize_request, only: [:destroy]
  before_action :set_player, only: [:show, :update, :destroy]

  def index
    @players = Player.all

    render json: @players, each_serializer: PlayerSerializer
  end

  def show
    render json: @player, serializer: PlayerSerializer
  end

  def create
    @player = Player.new(player_params.except(:playerSkills))
    player_skills_params = player_params[:playerSkills]

    if @player.save && valid_skills?(player_skills_params)
      create_player_skills(player_skills_params)
      render json: @player, serializer: PlayerSerializer, status: :created
    else
      @player.errors.add(:skill, 'is not a valid skill')
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  def update
    if @player.update(player_params.except(:playerSkills))
      update_player_skills(player_params[:playerSkills]) if player_params[:playerSkills].present?
      render json: @player, serializer: PlayerSerializer
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @player.destroy
    render json: { message: 'Player deleted' }
  end

  private

  def set_player
    @player ||= Player.find(params[:id])
  end

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

  def update_player_skills(player_skills_params)
    player_skills_params.each_with_index do |skill_params, index|
      player_skill = @player.player_skills[index]
      player_skill.update(skill_params)
    end
  end

  def authorize_request
    # return render json: { error: "Authorization header missing" }, status: :unauthorized unless request.headers['Authorization'].present?
    unless request.headers['Authorization'].present?
      render json: { error: "Authorization header missing" }, status: :unauthorized
      return
    end
    
    token = request.headers['Authorization'].split(' ').last

    unless valid_token?(token)
      render json: { error: "Invalid token" }, status: :unauthorized
      return
    end
  end

  def valid_token?(token)
    token == 'SkFabTZibXE1aE14ckpQUUxHc2dnQ2RzdlFRTTM2NFE2cGI4d3RQNjZmdEFITmdBQkE='
  end
end