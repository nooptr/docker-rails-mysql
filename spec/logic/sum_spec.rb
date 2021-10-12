require "rails_helper"

RSpec.describe "sum", type: :model do
  describe "sum" do
    let(:a) { 1 }
    let(:b) { 2 }

    context "plus + plus" do
      it do
        expect(a + b).to eq 3
      end
    end

    context "plus + minus" do
      let(:b) { -2 }
      it do
        expect(a + b).to eq -1
      end
    end
  end
end