class ReportJob
	@queue = :default

	def self.perform(report_id, hash={})
		report = Report.find(report_id)
		return if report.killed?

    report.status = :processing
    report.save
	end
end
