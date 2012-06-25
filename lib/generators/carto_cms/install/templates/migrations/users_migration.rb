class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      # Invitable
      t.string   :invitation_token, :limit => 60
      t.datetime :invitation_sent_at
      t.datetime :invitation_accepted_at
      t.integer  :invitation_limit
      t.integer  :invited_by_id
      t.string   :invited_by_type

      # Lockable
      t.integer  :failed_attempts, default: 0
      t.string   :unlock_token
      t.datetime :locked_at

      # Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      # Rememberable
      t.datetime :remember_created_at

      # Role
      t.boolean  :admin

      # Trackable
      t.integer  :sign_in_count, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # Timezone
      t.string   :time_zone

      # Slug
      t.string :slug, null: false

      t.timestamps
    end

    add_index :users, :email,            unique: true
    add_index :users, :unlock_token,     unique: true
    add_index :users, :invitation_token, unique: true
    add_index :users, :slug,             unique: true
  end
end
