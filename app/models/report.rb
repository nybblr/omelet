class Report < ActiveRecord::Base
  attr_accessible :app_id, :app_meta, :completed_at, :db_params, :query, :queued_at, :results, :status, :template, :title, :user_id, :user_meta

  serialize :app_meta, Hash
  serialize :user_meta, Hash
  serialize :query, Hash
  serialize :db_params, Hash

  scope :for, lambda {|aid, uid| where(:app_id => aid, :user_id => uid) }

  scope :pending,    where(:status => :pending)
  scope :queued,     where(:status => :queued)
  scope :processing, where(:status => :processing)
  scope :completed,  where(:status => :completed)

  stipulate :that => :status, :can_be => [:pending, :queued, :processing, :completed]

  def async_create_report
    Resque.enqueue(ReportJob, self.id)
  end
end
