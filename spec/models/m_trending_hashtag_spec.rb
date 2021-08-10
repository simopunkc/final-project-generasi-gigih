require "./models/m_api_db_trending_hashtag"

describe M_api_db_trending_hashtag do
    before(:each) do
        @double = instance_double(M_api_db_trending_hashtag)
    end
    it "#get_detail_hashtag" do
        hashtag = M_raw_hashtag.new(1,'')
        allow(@double).to receive(:get_detail_hashtag).with(hashtag.id).and_return(1)
        output = @double.get_detail_hashtag(hashtag.id)
        expect(@double).to have_received(:get_detail_hashtag).with(hashtag.id)
        expect(output).to eq(1)
        M_api_db_trending_hashtag.new.get_detail_hashtag(hashtag.id)
    end
    it "#get_trending_hashtag" do
        allow(@double).to receive(:get_trending_hashtag).and_return(1)
        output = @double.get_trending_hashtag
        expect(@double).to have_received(:get_trending_hashtag)
        expect(output).to eq(1)
        M_api_db_trending_hashtag.new.get_trending_hashtag
    end
end