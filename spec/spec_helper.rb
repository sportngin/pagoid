require 'active_record'
require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

require 'pagoid'

Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.before { Person.delete_all }

  # --seed 1234
  config.order = 'random'
end
