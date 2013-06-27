require 'pagoid/paging_adapter'
module Pagoid
  class AdapterRouter
    private
    attr_accessor :pageable

    def initialize(pageable)
      self.pageable = pageable
    end

    public

    def route
      chosen_adapter = route_table.find { |routeable| useable? routeable }
      raise RouterError, "Could not find a suitable Pagoid Adapter" unless chosen_adapter
      load_dependencies chosen_adapter
      constantize(pagoided(chosen_adapter)).new pageable
    end

    private

    def pagoided(adapter)
      "::Pagoid::#{adapter}"
    end

    def load_dependencies(adapter)
      require "pagoid/#{underscore(adapter)}"
    end

    def underscore(adapter_name)
      adapter_name.gsub(/::/, '/')
      .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
      .gsub(/([a-z\d])([A-Z])/,'\1_\2')
      .tr("-", "_")
      .downcase
    end

    def useable?(adapter)
      constantize "::#{adapter}"
    rescue NameError
      false
    end

    def constantize(adapter)
      Object.module_eval(adapter)
    end

    def route_table
      %w[
        Kaminari
        WillPaginate
      ]
    end
  end
end
