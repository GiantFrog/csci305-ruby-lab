require './ruby_lab'

RSpec.describe "Lab Questions Check" do
  context "Fixed the problem" do
    process_file("unique_tracks.txt")

    it "17. Song title starting with word 'montana'" do
      expect(create_title 'montana').to eq('montana sacra nova scotia')
      expect(create_title 'montana').to eq('montana sacra nova baby i love you re')
    end

    it "18. Song title starting with word 'bob'" do
      expect(create_title 'bob').to eq('bob marley song you re')
      expect(create_title 'bob').to eq('bob marley vs world is my heart')
      expect(create_title 'bob').to eq('bob marley me down nd i love you re')
      expect(create_title 'bob').to eq('bob marley purt drive me down nd')
      expect(create_title 'bob').to eq('bob marley medley 1 2')
    end
  end
end
