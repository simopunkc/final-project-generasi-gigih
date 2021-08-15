require "./models/m_api_db_search_hashtag"

describe M_api_db_search_hashtag do
    before(:each) do
        @double = instance_double(M_api_db_search_hashtag)
    end
    it "#get_id_hashtag" do
        tag = M_raw_hashtag.new('','good')
        allow(@double).to receive(:get_id_hashtag).with(tag.hashtag).and_return(1)
        output = @double.get_id_hashtag(tag.hashtag)
        expect(@double).to have_received(:get_id_hashtag).with(tag.hashtag)
        expect(output).to eq(1)
        M_api_db_search_hashtag.new.get_id_hashtag(tag.hashtag)
    end
end