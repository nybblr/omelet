class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.datetime :queued_at
      t.datetime :completed_at
      t.string :status
      t.string :title
      t.string :template
      t.string :app_id
      t.string :user_id
      t.text :db_params
      t.text :query
      t.text :results
      t.text :user_meta
      t.text :app_meta

      t.timestamps
    end
  end
end
