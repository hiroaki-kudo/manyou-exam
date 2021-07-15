enable_extension "plpgsql"

create_table "users", force: :cascade do |t|
  t.text "name"
  t.text "email"
end

end
