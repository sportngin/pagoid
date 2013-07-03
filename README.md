# Pagoid

[![Gem Version](https://badge.fury.io/rb/pagoid.png)](http://badge.fury.io/rb/pagoid)

Pagoid extracts the difference between [WillPaginate](https://github.com/mislav/will_paginate) and
[Kaminari](https://github.com/amatsuda/kaminari) as well as provides a standard callback
for things like publishing page info to your clients.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kaminari'
# OR
gem 'will_paginate'

gem 'pagoid'
```

And then execute:

```bash
$ bundle
```

## Usage

```ruby
class PeopleController < ApplicationController
  paged do |pager|
    metadata[:paging] = pager.headers if pager.display_headers?
  end

  def index
    @people = paginated Person
    render json: { metadata: metdata, result: @people }
  end

  private
  def metadata
    @metdata ||= {}
  end
end
```

You can stack `paged` blocks through inheritance:

```ruby
class ApplicationController < ActionController::Base
  paged do |pager|
    notice! pager.headers
  end

  def notice!(hash)
    Rails.logger.debug hash
  end
end

class PeopleController < ApplicationController
  #.. from above
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
