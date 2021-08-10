require "./models/m_api_db_single_post"

describe M_api_db_single_post do
    before(:each) do
        @double = instance_double(M_api_db_single_post)
    end
    it "#get_media_post" do
        post = M_raw_post.new(1,'','','','')
        allow(@double).to receive(:get_media_post).with(post.id).and_return(1)
        output = @double.get_media_post(post.id)
        expect(@double).to have_received(:get_media_post).with(post.id)
        expect(output).to eq(1)
        M_api_db_single_post.new.get_media_post(post.id)
    end
    it "#get_detail_media" do
        media = M_raw_media.new(1,'','')
        allow(@double).to receive(:get_detail_media).with(media.id).and_return(1)
        output = @double.get_detail_media(media.id)
        expect(@double).to have_received(:get_detail_media).with(media.id)
        expect(output).to eq(1)
        M_api_db_single_post.new.get_detail_media(media.id)
    end
    it "#get_detail_post" do
        post = M_raw_post.new(1,'','','','')
        allow(@double).to receive(:get_detail_post).with(post.id).and_return(1)
        output = @double.get_detail_post(post.id)
        expect(@double).to have_received(:get_detail_post).with(post.id)
        expect(output).to eq(1)
        M_api_db_single_post.new.get_detail_post(post.id)
    end
    it "#get_all_post_comment" do
        post = M_raw_post.new('','',1,'','')
        allow(@double).to receive(:get_all_post_comment).with(post.id_parent_post).and_return(1)
        output = @double.get_all_post_comment(post.id_parent_post)
        expect(@double).to have_received(:get_all_post_comment).with(post.id_parent_post)
        expect(output).to eq(1)
        M_api_db_single_post.new.get_all_post_comment(post.id_parent_post)
    end
end