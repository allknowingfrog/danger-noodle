require "./lib/board"

RSpec.describe Board do
  let(:board) { Board.new(height: 8, width: 8) }

  describe "#center" do
    subject { board.center }

    it { is_expected.to eq Location.new(x: 4, y: 4) }
  end

  describe "#contains?" do
    let(:x) { 4 }
    let(:y) { 4 }
    let(:location) { Location.new(x: x, y: y) }

    subject { board.contains?(location) }

    it { is_expected.to be(true) }

    describe "down" do
      let(:y) { -1 }

      it { is_expected.to be(false) }
    end

    describe "up" do
      let(:y) { 8 }

      it { is_expected.to be(false) }
    end

    describe "left" do
      let(:x) { -1 }

      it { is_expected.to be(false) }
    end

    describe "right" do
      let(:x) { 8 }

      it { is_expected.to be(false) }
    end
  end
end
