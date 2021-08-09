require "./controllers/c_api_db_tambah_post"

describe C_api_db_tambah_post do
    before(:each) do
        @double = instance_double(C_api_db_tambah_post)
    end
    it "should blank param id_member" do
        parameter = {"id_parent_post"=>"reserved","text"=>"reserved","media"=>"reserved"}
        allow(@double).to receive(:cek_param_request).with(parameter).and_return({:hasil => true, :pesan => "Parameter id_member tidak ditemukan"})
        output = @double.cek_param_request(parameter)
        expect(@double).to have_received(:cek_param_request).with(parameter)
        expect(output).to eq({:hasil => true, :pesan => "Parameter id_member tidak ditemukan"})
        C_api_db_tambah_post.new.cek_param_request(parameter)
    end
    it "should blank param id_parent_post" do
        parameter = {"id_member"=>"reserved","text"=>"reserved","media"=>"reserved"}
        allow(@double).to receive(:cek_param_request).with(parameter).and_return({:hasil => true, :pesan => "Parameter id_parent_post tidak ditemukan"})
        output = @double.cek_param_request(parameter)
        expect(@double).to have_received(:cek_param_request).with(parameter)
        expect(output).to eq({:hasil => true, :pesan => "Parameter id_parent_post tidak ditemukan"})
        C_api_db_tambah_post.new.cek_param_request(parameter)
    end
    it "should blank param text" do
        parameter = {"id_member"=>"reserved","id_parent_post"=>"reserved","media"=>"reserved"}
        allow(@double).to receive(:cek_param_request).with(parameter).and_return({:hasil => true, :pesan => "Parameter text tidak ditemukan"})
        output = @double.cek_param_request(parameter)
        expect(@double).to have_received(:cek_param_request).with(parameter)
        expect(output).to eq({:hasil => true, :pesan => "Parameter text tidak ditemukan"})
        C_api_db_tambah_post.new.cek_param_request(parameter)
    end
    it "should blank param media" do
        parameter = {"id_member"=>"reserved","id_parent_post"=>"reserved","text"=>"reserved"}
        allow(@double).to receive(:cek_param_request).with(parameter).and_return({:hasil => true, :pesan => "Parameter media tidak ditemukan"})
        output = @double.cek_param_request(parameter)
        expect(@double).to have_received(:cek_param_request).with(parameter)
        expect(output).to eq({:hasil => true, :pesan => "Parameter media tidak ditemukan"})
        C_api_db_tambah_post.new.cek_param_request(parameter)
    end
    it "should complete param json" do
        parameter = {"id_member"=>"reserved","id_parent_post"=>"reserved","text"=>"reserved","media"=>"reserved"}
        allow(@double).to receive(:cek_param_request).with(parameter).and_return({:hasil => false, :pesan => ""})
        output = @double.cek_param_request(parameter)
        expect(@double).to have_received(:cek_param_request).with(parameter)
        expect(output).to eq({:hasil => false, :pesan => ""})
        C_api_db_tambah_post.new.cek_param_request(parameter)
    end
    it "should create folder upload" do
        tgl = '2021-August-09'
        direktori = 'upload/'+tgl
        allow(@double).to receive(:create_folder_upload).and_return(direktori)
        output = @double.create_folder_upload
        expect(@double).to have_received(:create_folder_upload)
        expect(output).to eq(direktori)
        C_api_db_tambah_post.new.create_folder_upload
    end
    it "should blank ID member" do
        post = M_raw_post.new('','','','lorem ipsum','')
        allow(@double).to receive(:cek_valid).with(post.id_member,post.text).and_return({:hasil => true, :pesan => "ID member wajib diisi"})
        output = @double.cek_valid(post.id_member,post.text)
        expect(@double).to have_received(:cek_valid).with(post.id_member,post.text)
        expect(output).to eq({:hasil => true, :pesan => "ID member wajib diisi"})
        C_api_db_tambah_post.new.cek_valid(post.id_member,post.text)
    end
    it "should blank text" do
        post = M_raw_post.new('',1,'','','')
        allow(@double).to receive(:cek_valid).with(post.id_member,post.text).and_return({:hasil => true, :pesan => "Text wajib diisi"})
        output = @double.cek_valid(post.id_member,post.text)
        expect(@double).to have_received(:cek_valid).with(post.id_member,post.text)
        expect(output).to eq({:hasil => true, :pesan => "Text wajib diisi"})
        C_api_db_tambah_post.new.cek_valid(post.id_member,post.text)
    end
    it "should limit 1000" do
        text = 'A'
        until text.length > 1000 do
            text += 'A'
        end
        post = M_raw_post.new('',1,'',text,'')
        allow(@double).to receive(:cek_valid).with(post.id_member,post.text).and_return({:hasil => true, :pesan => "Text maksimal 1000 karakter"})
        output = @double.cek_valid(post.id_member,post.text)
        expect(@double).to have_received(:cek_valid).with(post.id_member,post.text)
        expect(output).to eq({:hasil => true, :pesan => "Text maksimal 1000 karakter"})
        C_api_db_tambah_post.new.cek_valid(post.id_member,post.text)
    end
    it "should detect all hashtag (alfabet,angka,underscore)" do
        post = M_raw_post.new('',1,'','#lorem haha #ipsum-5 jjk #generasigigih sir','')
        output = C_api_db_tambah_post.new.get_hashtag(post.text)
        expect(output).to eq(['lorem','generasigigih'])
    end
end