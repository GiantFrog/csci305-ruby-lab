require './ruby_lab'

RSpec.describe "Lab Questions Check" do
  context "unique_tracks without stop words removed" do
    process_file("unique_tracks.txt")

    it "6. Song title starting with 'happy'" do
      expect(create_title('happy')).to eq('happy birthday song for the world is a little girl in the world is a little girl in the world is')
    end

    it "7. Song title starting with 'sad'" do
      expect(create_title('sad')).to eq('sad song for the world is a little girl in the world is a little girl in the world is a')
    end

    it "8. Song title starting with 'hey'" do
      expect(create_title('hey')).to eq('hey hey hey hey hey hey hey hey hey hey hey hey hey hey hey hey hey hey hey hey hey')
    end

    it "9. Song title starting with 'little'" do
      expect(create_title('little')).to eq('little girl in the world is a little girl in the world is a little girl in the world is a')
    end
  end
end
