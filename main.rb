require 'json'
require 'sinatra'
require 'mysql2'
set :public_folder, File.dirname(__FILE__)
set :bind, "0.0.0.0"
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

get '/' do
    controller = C_api_db_trending_hashtag.new
    model = M_api_db_trending_hashtag.new
    daftar_hashtag = model.get_trending_hashtag
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
    # parameter = JSON.parse(request.body.read)
    # controller = C_api_db_tambah_post.new
    # error_request = controller.cek_param_request(parameter)
    # if error_request[:hasil] == true
    #     return JSON.generate(error_request)
    # end
    # error_value = controller.cek_valid(parameter["id_member"],parameter["id_parent_post"],parameter["text"])
    # if error_value[:hasil] == true
    #     return JSON.generate(error_value)
    # end
    # model = M_api_db_tambah_post.new
    # id_post = model.insert_post(parameter["id_member"],parameter["id_parent_post"],parameter["text"])
    # ambil_hashtag = controller.get_hashtag(parameter["text"])
    # if ambil_hashtag.size > 0
    #     ambil_hashtag.each do |hashtag|
    #         id_hashtag = model.get_id_hashtag(hashtag)
    #         if id_hashtag == 0
    #             id_hashtag = model.insert_hashtag(hashtag)
    #         end
    #         if model.cek_duplikat_hashtag(id_hashtag, id_post) == 0
    #             model.insert_hashtag_post(id_hashtag, id_post)
    #         end
    #     end
    # end
    puts request.accept
    # if params["media"] != nil and params["media"] != ""
    #     puts "fak"
    # end
end

get '/hashtag/:id' do
    controller = C_api_db_single_hashtag.new
    error_request = controller.cek_param_request(params)
    if error_request[:hasil] == true
        return JSON.generate(error_request)
    end
    error_value = controller.cek_valid(params[:id])
    if error_value[:hasil] == true
        return JSON.generate(error_value)
    end
    model = M_api_db_single_hashtag.new
    daftar_post = model.get_all_post(params[:id])
    kumpul_post = Array.new
    daftar_post.each do | data |
        post = model.get_detail_post(data)
        kumpul_post.push(controller.print_output(post))
    end
    return kumpul_post
end

get '/post/:id' do
    controller = C_api_db_single_post.new
    error_request = controller.cek_param_request(params)
    if error_request[:hasil] == true
        return JSON.generate(error_request)
    end
    error_value = controller.cek_valid(params[:id])
    if error_value[:hasil] == true
        return JSON.generate(error_value)
    end
    model = M_api_db_single_post.new
    data_post = model.get_detail_post(params[:id])
    data_comment = Array.new
    daftar_comment = model.get_all_post_comment(params[:id])
    daftar_comment.each do |comment|
        komen = model.get_detail_post(comment)
        data_comment.push(komen)
    end
    single_post = Array.new
    single_post.push(data_post)
    single_post.push(data_comment)
    return controller.print_output(single_post)
end