class ReportsController < ApplicationController
	respond_to :json

  # DRY the param lookup
  before_filter { @app_id = params[:app_id]
                  @user_id = params[:user_id] }

  # DRY up report lookup
  # Scope report by app_id, user_id, then search by absolute ID
  before_filter :except => [:index, :create] do
    @report = Report.for(@app_id, @user_id).find(params[:id])
  end

	def index
    @reports = Report.for(@app_id, @user_id)
	end

	def show

	end

	def create
    @callback = params[:callback]
    @query = params[:query]
    @db = params[:db]

	end

	def update

	end

  def destroy

  end
end
