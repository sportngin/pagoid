require "pagoid/version"
begin
  require 'kaminari'
  require 'kaminari/models/array_extension'
  if defined?(ActiveRecord::Base)
    require 'kaminari/models/active_record_extension'
    ::ActiveRecord::Base.send :include, Kaminari::ActiveRecordExtension
  end
rescue LoadError
  begin
    require 'will_paginate'
  rescue LoadError
    raise LoadError, "Please install kaminari or will_paginate for Pagoid backends"
  end
end

require 'pagoid/pager'
require 'pagoid/controller_extensions'
require 'pagoid/adapter_router'
require 'pagoid/engine' if defined?(Rails)

module Pagoid
end
