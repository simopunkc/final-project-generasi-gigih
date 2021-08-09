require "./models/m_raw_hashtag"
require "./models/m_raw_post"
require "./models/m_api_db_single_hashtag"

describe M_api_db_single_hashtag do
    before(:each) do
        @double = instance_double(M_api_db_single_hashtag)
    end
    it "#get_all_post" do
        tag = M_raw_hashtag.new(1,'')
        allow(@double).to receive(:get_all_post).with(tag.id).and_return(1)
        output = @double.get_all_post(tag.id)
        expect(@double).to have_received(:get_all_post).with(tag.id)
        expect(output).to eq(1)
        M_api_db_single_hashtag.new.get_all_post(tag.id)
    end
    it "#get_all_post_comment" do
        post = M_raw_post.new('','',1,'','')
        allow(@double).to receive(:get_all_post_comment).with(post.id_parent_post).and_return(1)
        output = @double.get_all_post_comment(post.id_parent_post)
        expect(@double).to have_received(:get_all_post_comment).with(post.id_parent_post)
        expect(output).to eq(1)
        M_api_db_single_hashtag.new.get_all_post_comment(post.id_parent_post)
    end
end