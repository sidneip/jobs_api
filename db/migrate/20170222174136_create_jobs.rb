class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :partner_id
      t.index :partner_id, unique: true
      t.references :category
      t.date :expired_at
      t.timestamps
    end
  end
end
