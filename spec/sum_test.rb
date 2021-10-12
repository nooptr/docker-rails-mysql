require "rails_helper"

RSpec.describe "sum", type: :model do
  describe "sum" do
    let(:a) { 1 }
    let(:b) { 2 }

    context "正の数の足し算" do
      it do
        expect(a + b).to eq 3
      end
    end
  end
end