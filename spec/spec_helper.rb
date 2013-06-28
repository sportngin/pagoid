require 'active_record'
require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

require 'pagoid'
root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "#{root}/db/pagoid.db"
)
ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS 'people'")
ActiveRecord::Base.connection.create_table(:people) do |t|
  t.string :name
  t.timestamps
end
class Person < ActiveRecord::Base
end
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.before { Person.delete_all }

  # --seed 1234
  config.order = 'random'
end
