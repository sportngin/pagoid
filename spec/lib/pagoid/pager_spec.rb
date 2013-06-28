require 'spec_helper'
module Pagoid
describe Pager do
  describe "array paging" do
    let(:paginatable) { (1..10).to_a }
    let(:options) { {} }
    subject { described_class.new paginatable, options }

    its(:paginated) { should == paginatable.reverse }
    its(:display_headers?) { should be_true }

    describe "with options" do
      let(:options) { { per_page: per_page, page: page } }
      let(:per_page) { 2 }
      let(:page) { 1 }

      its(:paginated) { should == [10,9] }
      its(:display_headers?) { should be_true }

      describe "sorting" do
        let(:options) { { per_page: per_page, page: page, order_by: :to_s } }

        its(:paginated) { should == [9,8] }
        its(:display_headers?) { should be_true }

        describe "with paging" do
          let(:page) { 3 }

          its(:paginated) { should == [5,4] }
          its(:display_headers?) { should be_true }

          describe "with direction" do
            let(:page) { nil }
            let(:options) { { per_page: per_page, page: page, order_by: :to_s, direction: "asc" } }

            its(:paginated) { should == [1,10] }
            its(:display_headers?) { should be_true }
          end
        end
      end
    end
  end

  describe "ActiveRecord paging" do
    before do
      %w[Adam Jon Mike Pat].each do |name|
        Person.create(name: name)
      end
    end

    let(:paginatable) { Person }
    let(:options) { {} }
    subject { described_class.new paginatable, options }

    its(:paginated) { should == paginatable.order("created_at desc").all }
    its(:display_headers?) { should be_true }

    describe "with options" do
      let(:options) { { per_page: per_page, page: page } }
      let(:per_page) { 2 }
      let(:page) { 1 }

      its(:paginated) { should == Person.first(2) }
      its(:display_headers?) { should be_true }

      describe "sorting" do
        let(:options) { { per_page: per_page, page: page, order_by: :name } }

        its(:paginated) { should == Person.order(options[:order_by]).first(2) }
        its(:display_headers?) { should be_true }

        describe "with paging" do
          let(:page) { 2 }

          its(:paginated) {
            should == Person.offset(options[:per_page] * (page - 1)).order(options[:order_by]).first(2)
          }
          its(:display_headers?) { should be_true }

          describe "with direction" do
            let(:page) { nil }
            let(:options) { { per_page: per_page, page: page, order_by: :name, direction: "asc" } }

            its(:paginated) { should == Person.order("name ASC").first(2) }
            its(:display_headers?) { should be_true }
          end
        end
      end
    end
  end
end
end
