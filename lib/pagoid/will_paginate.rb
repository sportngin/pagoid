require 'pagoid/paging_adapter'
module Pagoid
  class WillPaginate < PagingAdapter
    def total_count
      count
    end

    def limit_value
      per_page
    end

    def offset_value
      offset
    end

    def page(num)
      if array?
        chain __getobj__.paginate(page: num), original: __getobj__, page: num
      else
        chain super
      end
    end

    def per(num)
      if array?
        chain per_object.paginate(page: attributes[:page], per_page: num)
      else
        chain __getobj__.per_page(num)
      end
    end

    def first_page?
      current_page == 1
    end

    def last_page?
      current_page == total_pages
    end

    private

    def per_object
      attributes[:original] || __getobj__
    end

    def array?
      __getobj__.respond_to? :paginate
    end
  end
end
