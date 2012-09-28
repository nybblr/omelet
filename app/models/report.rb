class Report < ActiveRecord::Base
  attr_accessible :app_id, :app_meta, :completed_at, :db_params, :query, :queued_at, :results, :status, :template, :title, :user_id, :user_meta

  serialize :app_meta
  serialize :user_meta
  serialize :query
  serialize :db_params

  scope :for, lambda {|aid, uid| where(:app_id => aid, :user_id => uid) }

  scope :pending,    where(:status => :pending)
  scope :queued,     where(:status => :queued)
  scope :processing, where(:status => :processing)
  scope :completed,  where(:status => :completed)

  stipulate :that => :status, :can_be => [:pending, :queued, :processing, :completed]
end
