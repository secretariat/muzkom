# -*- encoding : utf-8 -*-
require 'digest/md5'
require 'net/http'
require 'uri'

class Leolink
	def initialize( request_uri )
		@request_uri = request_uri
		@leolink_key = "54ddce918f169"
		@fpath = "#{Rails.root}/public/leolink_folder"
		@links = []
		check_folder
	end

	def process
		@current_page = Digest::MD5.hexdigest(@request_uri)
		if needed_update?
			@links = get_and_save_links
		else
			@links = load_links_from_file
		end
	end

	def check_folder
		unless File.exist?( @fpath ) && File.directory?( @fpath )
			FileUtils.mkdir_p @fpath
		end
	end

	def needed_update?
		fname = "#{@fpath}/#{@current_page}"
		if File.exist?( "#{@fpath}/#{@current_page}" )
			return (Time.now - File.stat( fname ).atime > 12*60*60)
		else
			return true
		end
	end

	def	get_and_save_links
		get_data_from_srv
		fd = File.new("#{@fpath}/#{@current_page}", "w")
		fd.puts @links
		fd.close
		@links
	end

	def load_links_from_file
		File.readlines("#{@fpath}/#{@current_page}")
	end

	def get_data_from_srv
		uri = URI.parse("http://leolink.com.ua/")
		req = Net::HTTP::Get.new("http://leolink.com.ua/api/get_links.php?key=#{@leolink_key}&url=#{@current_page}")
    req.add_field('Accept', '*/*')

    res = Net::HTTP.start( uri.host, uri.port ) {|http|
      http.request(req)
    }
    unless res.body == "0"
    	@links = res.body.force_encoding(Encoding::UTF_8).split("\n")
    end
	end

end