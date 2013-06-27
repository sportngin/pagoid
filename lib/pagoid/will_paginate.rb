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
      chain(array? ? __getobj__.paginate(page: num) : super)
    end

    def per(num)
      chain(array? ? __getobj__.paginate(per_page: num) : __getobj__.per_page(num))
    end

    def first_page?
      current_page == 1
    end

    def last_page?
      current_page == total_pages
    end

    private

    def array?
      !__getobj__.respond_to?(:page) && !__getobj__.respond_to(:per_page)
    end
  end
end
