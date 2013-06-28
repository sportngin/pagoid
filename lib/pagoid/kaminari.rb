require 'pagoid/paging_adapter'
module Pagoid
  class Kaminari < PagingAdapter
    def coerce(coerceable = paginatable)
      coerce?(coerceable) ? ::Kaminari.paginate_array(Array(coerceable)) : coerceable
    end

    def page(*)
      PageProxy.new(super)
    end

    private

    def coerce?(coerceable = paginatable)
      !(
        coerceable.respond_to?(:order) &&
        coerceable.respond_to?(:page) &&
        coerceable.page.respond_to?(:per)
      )
    end

    class PageProxy < SimpleDelegator
      def per(*)
        Kaminari.new super
      end
    end
  end
end
