class ReportJob
	@queue = :default

	def self.perform(report_id, hash={})
		report = Report.find(report_id)
    report.status = :queued
    report.save
	end
end
