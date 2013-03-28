#!/usr/bin/env ruby
require 'sinatra'
require 'dm-core'
require 'date'

DataMapper::setup(:default, {:adapter => 'yaml', :path => 'db'})

class Comment
  include DataMapper::Resource
  property :id, Serial
  property :reply, String
  property :time, Date
  belongs_to :newt
end


class Newt
  include DataMapper::Resource
  property :id, Serial
  property :newtext, String
  property :time, Date
  has n, :comments
end

DataMapper.finalize

get "/homepage" do
  @postreplies=Comment.all(:order => [ :time.desc ])
  @postcreates=Newt.all(:order => [ :time.desc ])
  erb:homepage
end

get "/reply" do
  @allCreates = Newt.all
  @total = @allCreates.count
  @current = rand(@total)
  @formerone = Newt.get(@current)
  erb:reply_new 
end


post "/reply/save" do
   newreply=Comment.new
   newreply.reply = params[:replied]
   newreply.time = DateTime.now
   newreply.newt = Newt.get(params[:formercreate])
   if(newreply.save)
    @message = "Your reply was saved!"
  else
    @message = "Your reply was NOT SAVED!!!!!!!"
  end
     
  erb:reply_save
end

get "/create" do
  
  erb:create_new 
end


get "/create/:id" do
  #reply your past
  @postcreates = Newt.get(params[:id])
  erb:create_post
end

post "/create/save" do
  #create a new sentence
   newcreate=Newt.new
   newcreate.newtext = params[:created]
   newcreate.time = DateTime.now
   
   if(newcreate.save)
    @message = "Your create was saved!"
  else
    @message = "Your create was NOT SAVED!!!!!!!"
  end
   
  erb:create_save 
end
