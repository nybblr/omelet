class Report < ActiveRecord::Base
  attr_accessible :app_id, :app_meta, :completed_at, :db_params, :query, :queued_at, :results, :status, :template, :title, :user_id, :user_meta
end
