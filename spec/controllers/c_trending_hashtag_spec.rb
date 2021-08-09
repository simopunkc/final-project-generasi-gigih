require "./controllers/c_api_db_trending_hashtag"

describe C_api_db_trending_hashtag do
    it "should render view trending hashtag" do
        tag1 = M_raw_hashtag.new(1,'reserved')
        tag2 = M_raw_hashtag.new(1,'reserved')
        trending_hashtag = Array.new
        trending_hashtag.push(tag1)
        trending_hashtag.push(tag2)
        view = ERB.new(File.read("./views/v_api_db_trending_hashtag.erb")).result(binding)
        output = C_api_db_trending_hashtag.new.print_output(trending_hashtag)
        expect(output).to eq(view)
    end
end