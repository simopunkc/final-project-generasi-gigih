require 'json'
require 'sinatra'
require 'mysql2'
set :public_folder, File.dirname(__FILE__)
set :bind, "0.0.0.0"
# require "./controllers/c_output"
# require "./controllers/c_error"
# require "./controllers/c_api_db_tambah_member"

# class C_api_db_tambah_member
#     attr_accessor :foo, :bat
#     def initialize(foo=nil,bat=nil)
#         @foo = foo
#         @bat = bat
#     end
# end

# heeh = {"hasil" => "good", "pesan" => "haha"}
# out = JSON.generate(heeh)
# puts out.inspect
# ou2 = JSON.parse(out)
# puts ou2.inspect

# json = '{"foo": 1, "bat": 2}'
# hasil = JSON.parse(json)
# item = M_item.new(hasil["foo"],hasil["bat"])
# puts item.foo

post '/register' do
    parameter = JSON.parse(request.body.read)
    cek = C_api_db_tambah_member.cek_param_request(parameter)
    
    # output = C_api_db_tambah_member.cetak_homepage
    # if output.is_a?(String)
    #     C_output.cetak_output(output)
    # else
    #     C_error.cetak_error(output)
    # end
end

# get '/items/new' do
#     output = C_tambah_item.cetak_tambah_item
#     if output.is_a?(String)
#         C_output.cetak_output(output)
#     else
#         C_error.cetak_error(output)
#     end
# end

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