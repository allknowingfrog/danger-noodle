require "./lib/player"
require "./spec/helpers/scenario"

RSpec.describe Player do
  describe "::move" do
    subject { Player.move(data) }

    describe "with one safe option" do
      let(:data) do
        Scenario.generate(<<~TXT)
          ...........
          ...........
          ...........
          ...b.......
          ...bb......
          ....B......
          .....A.....
          .....a.....
          .....a.....
          ...........
          ...........
        TXT
      end

      it { is_expected.to eq("right") }
    end

    describe "with multiple safe option" do
      let(:data) do
        Scenario.generate(<<~TXT)
          ...........
          ...........
          ...........
          ...........
          ...bb......
          ....B......
          .....A.....
          .....a.....
          .....a.....
          .....a.....
          ...........
        TXT
      end

      it { is_expected.to eq("right") }
    end

    describe "with multiple safe options" do
      let(:health) { 51 }

      let(:data) do
        Scenario.generate(<<~TXT, health: {"A" => health})
          ...........
          ...........
          ...........
          ..*........
          .....*.....
          .....B.....
          .....bb....
          ......b....
          Aaa........
          .....*.....
          ...........
        TXT
      end

      it { is_expected.to eq("up") }

      describe "with low health" do
        let(:health) { 50 }

        it { is_expected.to eq("down") }
      end
    end

    describe "with a trapped space" do
      let(:data) do
        Scenario.generate(<<~TXT)
          ...........
          .....Bb....
          .....bb....
          ....bb.A...
          ....baaa...
          ..bbb.aa...
          ......aa...
          ...........
          ...........
          ...........
          ...........
        TXT
      end

      it { is_expected.to eq("up") }
    end

    describe "with a double trapped space" do
      let(:data) do
        Scenario.generate(<<~TXT)
          ...........
          ...........
          ...........
          ...........
          ....aaaa...
          ....aaaa...
          ....A..a...
          ....aaaa...
          ...........
          ...........
          ...........
        TXT
      end

      it { is_expected.to eq("left") }
    end

    describe "with a potentially-trapped space" do
      let(:data) do
        Scenario.generate(<<~TXT)
          ...........
          ...........
          ...........
          ...bbbB....
          ...b.......
          ..bbAaa....
          ..b..aa....
          ..bb.......
          ...bbb.....
          .....b.....
          ...........
        TXT
      end

      it { is_expected.to eq("down") }

      describe "with no other options" do
        let(:data) do
          Scenario.generate(<<~TXT)
            ...........
            ...........
            ...........
            ...bbbB....
            ...b.......
            ..bbAaa....
            ..b..aa....
            ..bbbb.....
            ...........
            ...........
            ...........
          TXT
        end

        it { is_expected.to eq("up") }
      end
    end

    describe "with a large, but potentially-trapped space" do
      let(:data) do
        Scenario.generate(<<~TXT)
          ......aaaa.
          .........a.
          ........aa.
          .......aa..
          ....aaaa...
          ....aaa....
          ....aaa....
          ....A...Bbb
          bbbbbb.bbbb
          .....b.bb..
          .....bbbb..
        TXT
      end

      it { is_expected.to eq("left") }
    end

    describe "with a potential incoming collision" do
      let(:data) do
        Scenario.generate(<<~TXT)
          ...........
          ...........
          ..bB.......
          .bb...Aa...
          .b....aa...
          ...........
          ...........
          ...........
          ...........
          ...........
          ...........
        TXT
      end

      it { is_expected.to eq("up") }
    end
  end
end
