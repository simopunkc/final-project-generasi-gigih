require "./controllers/c_api_db_tambah_post"

describe C_api_db_tambah_post do
    before(:each) do
        @double = instance_double(C_api_db_tambah_post)
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
end