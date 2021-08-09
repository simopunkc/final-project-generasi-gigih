require 'json'
require 'sinatra'
require 'mysql2'
set :public_folder, File.dirname(__FILE__)
set :bind, "0.0.0.0"
# require "./controllers/c_output"
# require "./controllers/c_error"
require "./models/m_koneksi_db"
require "./controllers/c_api_db_tambah_member"
require "./models/m_api_db_tambah_member"

post '/register' do
    parameter = JSON.parse(request.body.read)
    controller = C_api_db_tambah_member.new
    error_request = controller.cek_param_request(parameter)
    if error_request[:hasil] == true
        return JSON.generate(error_request)
    end
    error_value = controller.cek_valid(parameter["username"],parameter["email"])
    if error_value[:hasil] == true
        return JSON.generate(error_value)
    end
    model = M_api_db_tambah_member.new
    last_id = model.insert_member(parameter["username"],parameter["email"],parameter["bio"])
    if last_id > 0
        return JSON.generate({:id=>last_id,:pesan=>"success"})
    else
        return JSON.generate({:pesan=>"gagal insert ke db"})
    end
end

post '/posting' do
    parameter = JSON.parse(request.body.read)
    controller = C_api_db_tambah_post.new
    error_request = controller.cek_param_request(parameter)
    if error_request[:hasil] == true
        return JSON.generate(error_request)
    end
    error_value = controller.cek_valid(parameter["username"],parameter["email"],parameter["bio"])
end

# post '/items/create' do
#     output = C_db_tambah_item.simpan_item(params)
#     if output.is_a?(String)
#         redirect "/"
#     else
#         C_error.cetak_error(output)
#     end
# end

# get '/items/:id/edit' do
#     output = C_edit_item.cetak_edit_item(params)
#     if output.is_a?(String)
#         C_output.cetak_output(output)
#     else
#         C_error.cetak_error(output)
#     end
# end

# post '/items/:id/edit' do
#     output = C_db_edit_item.simpan_item(params)
#     if output.is_a?(String)
#         redirect "/"
#     else
#         C_error.cetak_error(output)
#     end
# end

# get '/items/:id' do
#     output = C_single_item.cetak_single_item(params)
#     if output.is_a?(String)
#         C_output.cetak_output(output)
#     else
#         C_error.cetak_error(output)
#     end
# end

# get '/items/:id/delete' do
#     output = C_db_delete_item.delete_item(params)
#     if output.is_a?(String)
#         redirect "/"
#     else
#         C_error.cetak_error(output)
#     end
# end

# get '/category/' do
#     output = C_daftar_kategori.cetak_daftar_kategori
#     if output.is_a?(String)
#         C_output.cetak_output(output)
#     else
#         C_error.cetak_error(output)
#     end
# end

# get '/category/new' do
#     output = C_tambah_kategori.cetak_tambah_kategori
#     if output.is_a?(String)
#         C_output.cetak_output(output)
#     else
#         C_error.cetak_error(output)
#     end
# end

# get '/category/:id' do
#     output = C_single_kategori.cetak_single_kategori(params)
#     if output.is_a?(String)
#         C_output.cetak_output(output)
#     else
#         C_error.cetak_error(output)
#     end
# end

# get '/category/:id/edit' do
#     output = C_edit_kategori.cetak_edit_kategori(params)
#     if output.is_a?(String)
#         C_output.cetak_output(output)
#     else
#         C_error.cetak_error(output)
#     end
# end

# get '/category/:id/delete' do
#     output = C_db_delete_kategori.delete_kategori(params)
#     if output.is_a?(String)
#         redirect "/category/"
#     else
#         C_error.cetak_error(output)
#     end
# end

# post '/category/create' do
#     output = C_db_tambah_kategori.simpan_kategori(params)
#     if output.is_a?(String)
#         redirect "/category/"
#     else
#         C_error.cetak_error(output)
#     end
# end

# post '/category/:id/edit' do
#     output = C_db_edit_kategori.simpan_kategori(params)
#     if output.is_a?(String)
#         redirect "/category/"
#     else
#         C_error.cetak_error(output)
#     end
# end

# get '/items/:id/category/' do
#     output = C_daftar_kategori_pada_item.cetak_daftar_kategori_pada_item(params)
#     if output.is_a?(String)
#         C_output.cetak_output(output)
#     else
#         C_error.cetak_error(output)
#     end
# end

# get '/items/:id/category/:kate_id/delete' do
#     output = C_db_delete_kategori_pada_item.delete_kategori(params)
#     if output.is_a?(String)
#         redirect "/items/#{params[:id]}/category/"
#     else
#         C_error.cetak_error(output)
#     end
# end