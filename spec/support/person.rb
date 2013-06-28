ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "./pagoid.db"
)

ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS 'people'")

ActiveRecord::Base.connection.create_table(:people) do |t|
  t.string :name
  t.timestamps
end

class Person < ActiveRecord::Base
end
