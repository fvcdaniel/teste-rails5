# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120513154734) do

  create_table "albums", :force => true do |t|
    t.string   "nome"
    t.string   "descricao"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contatos", :force => true do |t|
    t.string   "email"
    t.text     "texto"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formatos", :force => true do |t|
    t.string   "nome"
    t.string   "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "musicas", :force => true do |t|
    t.string   "nome"
    t.string   "artista"
    t.integer  "ano"
    t.string   "genero"
    t.string   "tamanho"
    t.string   "tempo"
    t.integer  "download"
    t.decimal  "preco"
    t.integer  "formato_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "arquivo"
    t.integer  "album_id"
    t.datetime "deleted_at"
  end

  add_index "musicas", ["formato_id"], :name => "index_musicas_on_formato_id"

  create_table "musicas_users", :id => false, :force => true do |t|
    t.integer  "musica_id"
    t.integer  "user_id"
    t.datetime "dt_compra"
    t.datetime "dt_pagamento"
  end

  create_table "pedidos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "musica_id"
    t.string   "status"
    t.decimal  "preco"
    t.string   "descricao"
    t.datetime "dt_pedido"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pedidos", ["musica_id"], :name => "index_pedidos_on_musica_id"
  add_index "pedidos", ["user_id"], :name => "index_pedidos_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "nm_usuario"
    t.string   "ds_email"
    t.string   "ds_senha"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "invited_at"
    t.integer  "invited_by"
    t.datetime "unsubscribed_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
