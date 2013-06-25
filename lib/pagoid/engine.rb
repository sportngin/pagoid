require 'rails/engine'
module Pagoid
  class Engine < Rails::Engine
    initializer 'pagoid.engine' do |app|
      ActiveSupport.on_load(:action_controller) do
        include Pagoid::ControllerExtensions
      end
    end
  end
end
