class Api::V1::NodesController < ApplicationController
  before_action :set_node, only: [:show, :update, :destroy]

  # GET /api/v1/nodes
  def index
    @nodes = Node.all
    if @nodes.blank?
      render status: 200, json: {succes: {status: 200, message: 'No existen nodos creados'}, data: @nodes}.to_json
    else
      render status: 200, json: {succes: {status: 200}, data: @nodes}.to_json
    end
  end

  # GET /api/v1/nodes/1
  def show
    if @node.nil?
      render status: 404, json: {error: {status: 404, message: "No se encuentra nodo con id=#{params[:id]}"}}.to_json
    else
      info = {
          'node': @node,
          'sensors': @node.sensors
      }
      render status: 200, json: {succes: {status: 200}, data: info}.to_json
    end
  end

  # POST /api/v1/nodes
  def create
    @group = Group.find_by_id(params[:group_id])
    if @group.nil?
      render status: 404, json: {error: {status: 404, message: "No se encuentra grupo con id=#{params[:id]}"}}.to_json
    else
      @node = Node.new(:modelName => params[:modelName], :manufacterName => params[:manufacterName], :description => params[:description])
      @node.group = @group
      params[:sensors].each do |item|
        sensor = Sensor.find_by_name(item[:name])
        if sensor.nil?
          puts "Sensor no existe"
        else
          @node.sensors << sensor
        end
      end
      if @node.save
        render status: 201, json: {succes: {status: 201, message: 'Nodo creado'}, data: @node}.to_json
      else
        render json: @node.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /api/v1/nodes/1
  def update
    if @node.update(node_params)
      render json: @node
    else
      render json: @node.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/nodes/1
  def destroy
    @node.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node
      @node = Node.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def node_params
      params.fetch(:node, {})
    end
end
