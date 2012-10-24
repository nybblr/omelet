class ReportsController < ApplicationController
	respond_to :json

	# DRY the param lookup
	before_filter {
		@app_id = params[:app_id]
		@user_id = params[:user_id]

		# Must give app_id and user_id!
		throw ActiveRecord::RecordNotFound if @app_id.blank? or @user_id.blank?
	}

	# DRY up report lookup
	# Scope report by app_id, user_id, then search by absolute ID
	before_filter :except => [:index, :create] do
		@report = Report.for(@app_id, @user_id).find(params[:id])
	end

	def index
		@reports = Report.for(@app_id, @user_id)
	end

	def show
		@report = Report.for(@app_id, @user_id).find(params[:id])
	end

	def create
		@callback = params[:callback]
		# @query = params[:query]
		@db = params[:db_params]
		@report = Report.new params[:report]
		@report.status = :queued
		@report.app_id = @app_id
		@report.save

		@report.async_create(@db, @callback)

		render :nothing => true
	end

	def update

	end

	def destroy
		@report = Report.for(@app_id, @user_id).find(params[:id])
		@report.async_destroy
		# @report.destroy

		render :nothing => true
	end
end
