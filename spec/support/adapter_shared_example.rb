shared_examples "a specific page adaptation" do
  it { should respond_to :page }

  describe "post-page methods" do
    subject { described_class.new(decorated).page(1) }
    it { should respond_to :coerce }
    it { should respond_to :total_count }
    it { should respond_to :total_pages }
    it { should respond_to :first_page? }
    it { should respond_to :last_page? }
    it { should respond_to :current_page }
    it { should respond_to :limit_value }
    it { should respond_to :offset_value }
    it { should respond_to :per }
  end
end

shared_examples "a pager adapter" do
  subject { described_class.new decorated }
  let(:decorated) { [] }

  it_should_behave_like "a specific page adaptation"

  describe "with active record" do
    let(:decorated) { Person }

    it_should_behave_like "a specific page adaptation"
  end
end
