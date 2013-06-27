module Pagoid
  module ControllerExtensions
    def self.included(base)
      base.extend ClassMethods
    end

    def paginated(resource)
      pager = Pager.new(resource, params)
      self.class.apply_pager_blocks(self, pager)
      pager.paginated
    end

    module ClassMethods
      def paged(&block)
        @pagination_block = block
      end

      def apply_pager_blocks(context, pager_instance)
        pager_blocks.each { |block| context.instance_exec(pager_instance, &block) }
      end

      def pager_block
        @pagination_block || ->(x) { x }
      end
      private :pager_block

      def pager_blocks
        [pager_block] + (superclass.respond_to?(:pager_blocks) ? superclass.pager_blocks : [])
      end
      protected :pager_blocks
    end
  end
end
