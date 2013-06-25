require "pagoid/version"
begin
  require 'kaminari'
  require 'kaminari/models/array_extension'
rescue LoadError
  begin
    require 'will_paginate'
  rescue LoadError
    raise LoadError, "Please install kaminari or will_paginate for Pagoid backends"
  end
end

require 'pagoid/pager'
require 'pagoid/controller_extensions'
require 'pagoid/engine' if defined?(Rails)

module Pagoid
end
