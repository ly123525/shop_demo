# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180120015357) do

  create_table "product_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.integer  "weight",         default: 0
    t.integer  "products_count", default: 0
    t.integer  "parent_id"
    t.integer  "lft",                        null: false
    t.integer  "rgt",                        null: false
    t.integer  "depth",          default: 0, null: false
    t.integer  "children_count", default: 0, null: false
    t.integer  "position",       default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["lft"], name: "index_product_categories_on_lft", using: :btree
    t.index ["parent_id"], name: "index_product_categories_on_parent_id", using: :btree
    t.index ["position"], name: "index_product_categories_on_position", using: :btree
    t.index ["rgt"], name: "index_product_categories_on_rgt", using: :btree
    t.index ["title"], name: "index_product_categories_on_title", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "product_category_id"
    t.string   "title"
    t.string   "status",                                                     default: "off"
    t.integer  "amount",                                                     default: 0
    t.string   "uuid"
    t.decimal  "msrp",                              precision: 10, scale: 2
    t.decimal  "price",                             precision: 10, scale: 2
    t.text     "description",         limit: 65535
    t.datetime "created_at",                                                                 null: false
    t.datetime "updated_at",                                                                 null: false
    t.index ["product_category_id"], name: "index_products_on_product_category_id", using: :btree
    t.index ["status", "product_category_id"], name: "index_products_on_status_and_product_category_id", using: :btree
    t.index ["title"], name: "index_products_on_title", using: :btree
    t.index ["uuid"], name: "index_products_on_uuid", unique: true, using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                           null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.index ["activation_token"], name: "index_users_on_activation_token", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  end

end
