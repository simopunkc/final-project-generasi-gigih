require 'json'
require 'sinatra'
require 'mysql2'
require 'fileutils'
require 'date'
require 'mimemagic'
require 'securerandom'
set :public_folder, File.dirname(__FILE__)
set :bind, "0.0.0.0"
require "./controllers/c_modules/c_cek_integer"
require "./models/m_koneksi_db"
require "./models/m_raw_post"
require "./models/m_raw_hashtag"
require "./models/m_raw_media"
require "./models/m_raw_member"
require "./controllers/c_api_db_trending_hashtag"
require "./models/m_api_db_trending_hashtag"
require "./controllers/c_api_db_tambah_member"
require "./models/m_api_db_tambah_member"
require "./controllers/c_api_db_tambah_post"
require "./models/m_api_db_tambah_post"
require "./controllers/c_api_db_single_hashtag"
require "./models/m_api_db_single_hashtag"
require "./controllers/c_api_db_single_post"
require "./models/m_api_db_single_post"
require "./controllers/c_api_db_search_hashtag"
require "./models/m_api_db_search_hashtag"

get '/' do
    controller = C_api_db_trending_hashtag.new
    model = M_api_db_trending_hashtag.new
    daftar_hashtag = model.get_trending_hashtag
    if daftar_hashtag.size == 0
        return "tidak ada hashtag terbaru dalam 24 jam terakhir"
    end
    raw = Array.new
    daftar_hashtag.each do |data|
        trending_hashtag = model.get_detail_hashtag(data)
        raw.push(controller.print_output(trending_hashtag))
    end
    return raw
end

post '/register' do
    parameter = JSON.parse(request.body.read)
    controller = C_api_db_tambah_member.new
    error_request = controller.cek_param_request(parameter)
    headers "Content-Type" => "application/json; charset=utf-8"
    if error_request[:hasil] == true
        status 400
        return JSON.generate(error_request)
    end
    error_value = controller.cek_valid(parameter["username"],parameter["email"])
    if error_value[:hasil] == true
        status 400
        return JSON.generate(error_value)
    end
    model = M_api_db_tambah_member.new
    last_id = model.insert_member(parameter["username"],parameter["email"],parameter["bio"])
    if last_id > 0
        status 201
        return JSON.generate({:id=>last_id,:pesan=>"success"})
    else
        status 400
        return JSON.generate({:pesan=>"gagal insert ke db"})
    end
end

post '/posting' do
    controller = C_api_db_tambah_post.new
    error_request = controller.cek_param_request(params)
    headers "Content-Type" => "application/json; charset=utf-8"
    if error_request[:hasil] == true
        status 400
        return JSON.generate(error_request)
    end
    error_value = controller.cek_valid(params["id_member"],params["id_parent_post"],params["text"])
    if error_value[:hasil] == true
        status 400
        return JSON.generate(error_value)
    end
    model = M_api_db_tambah_post.new
    id_post = model.insert_post(params["id_member"],params["id_parent_post"],params["text"])
    ambil_hashtag = controller.get_hashtag(params["text"])
    if ambil_hashtag.size > 0
        ambil_hashtag.each do |hashtag|
            id_hashtag = model.get_id_hashtag(hashtag)
            if id_hashtag == 0
                id_hashtag = model.insert_hashtag(hashtag)
            end
            if model.cek_duplikat_hashtag(id_hashtag, id_post) == 0
                model.insert_hashtag_post(id_hashtag, id_post)
            end
        end
    end
    if params["media"] == nil or params["media"] == ""
        status 201
        return JSON.generate({:id=>id_post,:pesan=>"success"})
    end
    dir_upload = controller.create_folder_upload(params["id_member"])
    filename = controller.hapus_spesial_character(params['media'][:filename])
    uniqid = SecureRandom.hex(4)
    lokasi = dir_upload+uniqid+filename
    File.open(lokasi,"w") do |f|
        f.write(params['media'][:tempfile].read)
    end
    mime = MimeMagic.by_magic(File.open(lokasi))
    id_media = model.insert_media(lokasi,mime)
    id_post_media = model.insert_post_media(id_post,id_media)
    status 201
    return JSON.generate({:id=>id_post,:pesan=>"success upload"})
end

get '/hashtag/:id' do
    controller = C_api_db_single_hashtag.new
    error_request = controller.cek_param_request(params)
    if error_request[:hasil] == true
        status 400
        headers "Content-Type" => "application/json; charset=utf-8"
        return JSON.generate(error_request)
    end
    error_value = controller.cek_valid(params[:id])
    if error_value[:hasil] == true
        status 400
        headers "Content-Type" => "application/json; charset=utf-8"
        return JSON.generate(error_value)
    end
    model = M_api_db_single_hashtag.new
    daftar_post = model.get_all_post(params[:id])
    kumpul_post = Array.new
    daftar_post.each do | data |
        post = model.get_detail_post(data)
        kumpul_post.push(controller.print_output(post))
    end
    status 200
    return kumpul_post
end

get '/search/:name' do
    controller = C_api_db_search_hashtag.new
    error_request = controller.cek_param_request(params)
    if error_request[:hasil] == true
        status 400
        headers "Content-Type" => "application/json; charset=utf-8"
        return JSON.generate(error_request)
    end
    error_value = controller.cek_valid(params[:name])
    if error_value[:hasil] == true
        status 400
        headers "Content-Type" => "application/json; charset=utf-8"
        return JSON.generate(error_value)
    end
    parameter = params[:name].downcase
    model = M_api_db_search_hashtag.new
    id_hashtag = model.get_id_hashtag(parameter)
    if id_hashtag == 0
        status 400
        headers "Content-Type" => "application/json; charset=utf-8"
        return JSON.generate({:pesan=>"hashtag tidak ditemukan"})
    else
        tag = M_raw_hashtag.new(id_hashtag,parameter)
        controller.print_output(tag)
    end
end

get '/post/:id' do
    controller = C_api_db_single_post.new
    error_request = controller.cek_param_request(params)
    if error_request[:hasil] == true
        status 400
        headers "Content-Type" => "application/json; charset=utf-8"
        return JSON.generate(error_request)
    end
    error_value = controller.cek_valid(params[:id])
    if error_value[:hasil] == true
        status 400
        headers "Content-Type" => "application/json; charset=utf-8"
        return JSON.generate(error_value)
    end
    model = M_api_db_single_post.new
    single_post = Array.new
    data_media = Array.new
    data_post = Array.new
    data_comment = Array.new
    daftar_media = model.get_media_post(params[:id])
    daftar_media.each do |media|
        file = model.get_detail_media(media)
        data_media.push(file)
    end
    data_post = model.get_detail_post(params[:id])
    daftar_comment = model.get_all_post_comment(params[:id])
    daftar_comment.each do |comment|
        komen = model.get_detail_post(comment)
        data_comment.push(komen)
    end
    single_post.push(data_media)
    single_post.push(data_post)
    single_post.push(data_comment)
    status 200
    return controller.print_output(single_post)
end