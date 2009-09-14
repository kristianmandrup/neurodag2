class CreateAll < ActiveRecord::Migration
  def self.up
    create_table "abstracts", :force => true do |t|
      t.integer  "user_id"
      t.integer  "conference_id"
      t.string   "title"
      t.text     "body"
      t.text     "authors"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "audits", :force => true do |t|
      t.integer  "auditable_id"
      t.string   "auditable_type"
      t.integer  "user_id"
      t.string   "user_type"
      t.string   "username"
      t.string   "action"
      t.text     "changes"
      t.integer  "version",        :default => 0
      t.datetime "created_at"
    end

    add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
    add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
    add_index "audits", ["user_id", "user_type"], :name => "user_index"

    create_table "blogs", :force => true do |t|
      t.integer  "user_id"
      t.string   "title"
      t.integer  "conference_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "body"
    end

    create_table "comments", :force => true do |t|
      t.integer  "user_id"
      t.integer  "post_id"
      t.text     "body"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "competitions", :force => true do |t|
      t.string   "title"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "conference_id"
    end

    create_table "conferences", :force => true do |t|
      t.string   "title"
      t.date     "year"
      t.text     "description"
      t.text     "venue"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "faqs", :force => true do |t|
      t.integer  "user_id",           :null => false
      t.text     "schools"
      t.text     "companies"
      t.text     "books_written"
      t.text     "short_cv"
      t.text     "selected_papers"
      t.text     "work_experience"
      t.text     "job_advertisement"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "friendships", :force => true do |t|
      t.integer  "user_id"
      t.integer  "friend_id"
      t.string   "status"
      t.datetime "created_at"
      t.datetime "accepted_at"
    end

    create_table "pages", :force => true do |t|
      t.string   "title"
      t.text     "body"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "conference_id"
      t.integer  "parent_id"
      t.text     "embedded_video_html"
    end

    create_table "posters", :force => true do |t|
      t.string   "title"
      t.text     "abstract"
      t.text     "authors"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "registration_id"
      t.integer  "user_id"
      t.integer  "conference_id"
    end

    create_table "posts", :force => true do |t|
      t.integer  "blog_id"
      t.string   "title"
      t.text     "body"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "rates", :force => true do |t|
      t.integer  "user_id"
      t.integer  "rateable_id"
      t.string   "rateable_type"
      t.integer  "stars"
      t.string   "dimension"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "rates", ["rateable_id"], :name => "index_rates_on_rateable_id"
    add_index "rates", ["user_id"], :name => "index_rates_on_user_id"

    create_table "ratings", :force => true do |t|
      t.integer  "rating",                      :default => 0
      t.datetime "created_at",                                  :null => false
      t.string   "rateable_type", :limit => 15, :default => "", :null => false
      t.integer  "rateable_id",                 :default => 0,  :null => false
      t.integer  "user_id",                     :default => 0,  :null => false
    end

    add_index "ratings", ["user_id"], :name => "fk_ratings_user"

    create_table "registrations", :force => true do |t|
      t.string   "type"
      t.integer  "user_id"
      t.integer  "conference_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "participate_competition"
      t.boolean  "selected_for_competition"
      t.boolean  "bringing_posters"
      t.boolean  "plenary_speaker"
      t.boolean  "payment_status"
    end

    create_table "sessions", :force => true do |t|
      t.string   "session_id"
      t.text     "data"
      t.datetime "updated_at"
    end

    add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
    add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

    create_table "specs", :force => true do |t|
      t.integer  "user_id",                    :null => false
      t.string   "gender"
      t.date     "birthdate"
      t.string   "occupation", :default => ""
      t.string   "city",       :default => ""
      t.string   "title"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "talks", :force => true do |t|
      t.string   "title"
      t.text     "abstract"
      t.integer  "registration_id"
      t.integer  "conference_id"
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "users", :force => true do |t|
      t.string   "screen_name"
      t.string   "email"
      t.string   "password"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "authorization_token"
      t.string   "role"
      t.string   "first_name",          :default => ""
      t.string   "last_name",           :default => ""
    end

    create_table "videos", :force => true do |t|
      t.integer  "page_id"
      t.string   "title"
      t.string   "description"
      t.string   "url"
      t.integer  "height"
      t.integer  "width"
      t.string   "type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

  end

  def self.down
    drop_table :users
  end
end