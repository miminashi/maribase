#coding:utf-8
require 'sinatra/base'
#require 'sinatra/reloader' if ENV['RACK_ENV'] == 'development'
require 'sinatra/r18n'
require 'haml'

#require File.expand_path('', File.dirname(__FILE__))

module MariBase
  def self.route(_path='')
    pathes = []
    entries = Dir.entries(File.expand_path(File.join('views', _path), File.dirname(__FILE__))).reject{|e| e == '.' or e == '..'}
    entries.each do |entry|
      entry_expand_path = File.expand_path(File.join('views', _path, entry), File.dirname(__FILE__))
      #puts "#{entry}: #{entry_expand_path}"
      ftype = File.ftype(entry_expand_path)
      if ftype == 'directory'
        pathes += MariBase.route(File.join(_path, entry))
        MariBase.route(File.join(_path, entry))
      elsif ftype == 'file' and entry.split('.')[-1] == 'haml' and entry != 'layout.haml'
        #pathes << File.join(_path, entry).gsub(/^\//, '').gsub(/\.haml$/, '').to_sym
        pathes << File.join(_path, entry).gsub(/\.haml$/, '')
      end
    end
    return pathes
  end 

  class Web < Sinatra::Base
    #configure :development do
    #  register Sinatra::Reloader
    #  also_reload './i18n/ja.yml'
    #end
    register Sinatra::R18n

    routes = MariBase.route
    routes.each do |r|
      if r == '/index'
        puts 'defining path: /'
        get '/' do
          haml :index
        end
      else
        puts "defining path: #{r}"
        get r do
          haml r.gsub(/^\//, '').to_sym
        end
      end
    end
  end # of Web < Sinatra::Base
end

