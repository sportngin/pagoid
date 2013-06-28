require 'spec_helper'
require 'pagoid/will_paginate'
require 'will_paginate'
require 'will_paginate/array'
module Pagoid
  describe WillPaginate do
    subject { described_class.new decorated }
    before do
      AdapterRouter.any_instance.stub configured: "WillPaginate"
    end

    let(:decorated) { [] }

    it_should_behave_like "a pager adapter"

    describe "with active record" do
      let(:decorated) { Person }

      its(:coerce) { should == Person }
    end
  end
end
