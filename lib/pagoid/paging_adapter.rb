require 'delegate'
module Pagoid
  class PagingAdapter < SimpleDelegator
    attr_accessor :paginatable
    attr_accessor :attributes

    def initialize(paginatable, attributes = {})
      self.paginatable = paginatable
      self.attributes = attributes
      super coerce
    end

    def coerce(coerceable = paginatable)
      coerceable
    end

    %w[page per order].each do |meth|
      define_method(meth) do |*args|
        chain(super(*args))
      end
    end

    def chain(object, state = {})
      self.class.new object, state
    end
  end
end
