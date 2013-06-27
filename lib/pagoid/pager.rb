require 'forwardable'
# Service Class for handling of adapting paging for both Arrays and ActiveRecord objects.
# An array of AR Objects should come out the same as if you were to pass in a relation (though
# likely much slower).
#
# Defaults:
#   page: 1
#   per_page: 100
#   order_by: Object <=> Object
#   direction: Descending
module Pagoid
  class Pager
    extend Forwardable
    def_delegators :paginatable, :coerce

    # Initialize
    #
    # @param [Object] paginatable Some object(like an Array or ActiveRecord Object) for pagination
    # @param [Hash] options options hash for tweaking pagination
    # @option options [Fixnum] :page The page number
    # @option options [Fixnum] :per_page The page size
    # @option options [Fixnum] :order_by Callable on each element (or column) to sort by
    # @option options [Fixnum] :direction "desc" or "asc"
    def initialize(paginatable, options = {})
      self.paginatable = paginatable
      self.options = options.dup
    end

    # Memoized method of Paged, Sized, and Ordered output
    #
    # @return ordered, sized, paged data
    def paginated
      @paginated ||= pered
    end

    # Hash of data for publishing on a payload for Paging reference
    #
    # @return [Hash] hash of paging data
    def headers
      {
        total: paginated.total_count,
        total_pages: paginated.total_pages,
        first_page: paginated.first_page?,
        last_page: paginated.last_page?,
        current_page: paginated.current_page,
        limit: paginated.limit_value,
        offset: paginated.offset_value
      }
    end

    # Describes whether or not to publish paging reference
    #
    # @return boolean describing whether to display pagination headers
    def display_headers?
      paginated.present?
    end

    private

    attr_accessor :paginatable
    attr_accessor :options

    def pered
      should_per? ? paged.per(per_page) : paged
    end

    def ordered
      should_order? ? coerce(order_method_hash[order_method].call(paginatable)) : coerce
    end

    def paged
      ordered.page(page)
    end

    def coerce(coerceable = paginatable)
      force_coerce? ? Kaminari.paginate_array(Array(coerceable)) : coerceable
    end

    def force_coerce?(coerceable = paginatable)
      !(
        coerceable.respond_to?(:order) &&
        coerceable.respond_to?(:page) &&
        coerceable.page.respond_to?(:per)
      )
    end

    def should_order?
      order_method.present?
    end

    def should_per?
      per_page.present?
    end

    def per_page
      options[:per_page].to_i > 0 ? options[:per_page].to_i : 100
    end

    def order_method
      order_methods.find { |method| coerce.respond_to? method }
    end

    def order_method_hash
      {
        order: ->(orderable) { orderable.order "#{order_by} #{direction}" },
        sort: ->(orderable) {
          orderable.sort { |a,b|
            direction == :asc ? order_by_value(a) <=> order_by_value(b) : order_by_value(b) <=> order_by_value(a)
          }
        }
      }
    end

    def order_by_value(orderable)
      orderable.respond_to?(order_by) ? orderable.public_send(order_by) : orderable
    end

    def order_methods
      order_method_hash.keys
    end

    def page
      options[:page].to_i > 0 ? options[:page].to_i : 1
    end

    def order_by
      (options[:order_by].present? ? options[:order_by] : :created_at).to_s
    end

    def direction
      options[:direction].to_s == "asc" ? :asc : :desc
    end
  end
end
