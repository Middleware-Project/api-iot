class Api::V1::GroupsController < ApplicationController
  before_action :set_group, only: [:show, :update, :destroy]

  # GET /api/v1/groups
  def index
    @groups = Group.all
    if @groups.blank?
      render status: 200, json: {succes: {status: 200, message: 'No existen grupos creados'}, data: @groups}.to_json
    else
      render status: 200, json: {succes: {status: 200}, data: @groups}.to_json
    end
  end

  # GET /api/v1/groups/1
  def show
    if @group.nil?
      render status: 404, json: {error: {status: 404, message: "No se encuentra grupo con id=#{params[:id]}"}}.to_json
    else
      info = {
          'group': @group,
          'nodes': @group.nodes
      }
      render status: 200, json: {succes: {status: 200}, data: info}.to_json
    end
  end

  # POST /api/v1/groups
  def create
    @group = Group.new(:name => params[:name], :description => params[:description])

    if @group.save
      render status: 201, json: {succes: {status: 201, message: 'Grupo creado'}, data: @group}.to_json
    else
      render status: 422, json: {error: {status: :unprocessable_entity, message: @group.errors}}.to_json
    end

  end

  # PATCH/PUT /api/v1/groups/1
  def update
    if @group.update(group_params)
      render json: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/groups/1
  def destroy
    @group.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find_by_id(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def group_params
      params.fetch(:group, {})
    end
end
