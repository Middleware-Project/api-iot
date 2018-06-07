class Api::V1::MeasuresController < ApplicationController
  before_action :set_measure, only: [:show, :update, :destroy]

  # GET /api/v1/measures
  def index
    @measures = Measure.all
    if @measures.blank?
      render status: 200, json: {succes: {status: 200, message: 'No existen mediciones creadas'}, data: @measures}.to_json
    else
      render status: 200, json: {succes: {status: 200}, data: @measures}.to_json
    end
  end

  # GET /api/v1/measures/1
  def show

    if @measure.nil?
      render status: 404, json: {error: {status: 404, message: "No se encuentra medida con id=#{params[:id]}"}}.to_json
    else
      info = {
          'measure': @measure,
          'node': @measure.node,
          'sensor': @measure.sensor
      }
      render status: 200, json: {succes: {status: 200}, data: info}.to_json
    end
  end

  # POST /api/v1/measures
  def create
    @node = Node.find_by_id(params[:node_id])
    @sensor = Sensor.find_by_id(params[:sensor_id])

    if @node.nil? || @sensor.nil?
      render status: 404, json: {error: {status: 404, message: "No se encuentra nodo con id=#{params[:node_id]}"}}.to_json
    else
      @measure = Measure.new(:data => params[:data], :unit => params[:unit],:node => @node,:sensor => @sensor)
      if @measure.save
        render json: @measure, status: :created
      else
        render json: @measure.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /api/v1/measures/1
  def update
    if @measure.update(measure_params)
      render json: @measure
    else
      render json: @measure.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/measures/1
  def destroy
    @measure.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_measure
      @measure = Measure.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def measure_params
      params.fetch(:measure, {})
    end
end
