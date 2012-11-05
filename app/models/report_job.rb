class ReportJob
	@queue = :default

	def self.perform(report_id, hash={})
		report = Report.find(report_id)
		return if report.killed?

    report.status = :processing
    report.save

		# Try to open database connection
		db = ActiveRecord::Base.establish_connection hash[:db]

		# Try to execute query!
		results = db.connection.execute report.query

		report.results = results
		report.status = :finished
		report.save
	end
end
