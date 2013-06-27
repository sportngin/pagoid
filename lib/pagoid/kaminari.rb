module Pagoid
  class Kaminari < PagingAdapter
    def coerce(coerceable = paginatable)
      coerce?(coerceable) ? ::Kaminari.paginate_array(Array(coerceable)) : coerceable
    end

    def coerce?(coerceable = paginatable)
      !(
        coerceable.respond_to?(:order) &&
        coerceable.respond_to?(:page) &&
        coerceable.page.respond_to?(:per)
      )
    end
  end
end
