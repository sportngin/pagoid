module Pagoid
  class PagingAdapter < SimpleDelegator
    attr_accessor :paginatable

    def initialize(paginatable)
      self.paginatable = paginatable
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

    def chain(object)
      self.class.new object
    end
  end
end
