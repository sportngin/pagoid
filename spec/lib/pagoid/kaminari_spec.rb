require 'spec_helper'
require 'pagoid/kaminari'
require 'kaminari'
require 'kaminari/models/array_extension'
module Pagoid
  describe Kaminari do
    subject { described_class.new decorated }
    before do
      AdapterRouter.any_instance.stub configured: "Kaminari"
    end

    let(:decorated) { [] }

    it_should_behave_like "a pager adapter"

    its(:coerce) { should be_a ::Kaminari::PaginatableArray }

    describe "with active record" do
      let(:decorated) { Person }

      its(:coerce) { should == Person }
    end
  end
end
