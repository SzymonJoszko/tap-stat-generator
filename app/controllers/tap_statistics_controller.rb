class TapStatisticsController < ApplicationController
  before_action :set_tap_statistic, only: %i[ show update destroy ]

  # GET /tap_statistics
  def index
    @tap_statistics = TapStatistic.all

    render json: @tap_statistics
  end

  # GET /tap_statistics/1
  def show
    render json: @tap_statistic
  end

  # POST /tap_statistics
  def create
    @tap_statistic = TapStatistic.new(tap_statistic_params)

    if @tap_statistic.save

      # render json: @tap_statistic, status: :created, location: @tap_statistic
      send_data @tap_statistic.generate_report_workbook.stream.string, filename: "report#{@tap_statistic.id}.xlsx",
                                    disposition: 'attachment', status: :created, type: :json
    else
      render json: @tap_statistic.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tap_statistic
      @tap_statistic = TapStatistic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tap_statistic_params
      username = params.require(:username)
      measurements = params.require(:measurements)
      {
        tap_statistic_json: {
          username: username,
          measurements: measurements
        }
      }
    end
end
