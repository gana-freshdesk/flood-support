require 'set'
class PostsController < ApplicationController
  respond_to :html, :js
  
	def index
		@locations = Set.new
		@materials = Set.new
		@materials.add?("All")
		@posts = Post.getAll
		#puts @posts
		#@locations = Set.new
		#@materials = Set.new
		
		@posts.each do |post|
			if post.location != nil
				#puts post.location.split(',')
				ls = post.location.split(',')
				ls.each do |l|
					l = l.strip
					if !@locations.include?(l)
						@locations.add?(l)
					end
				end
			end

			if post.materials == nil
				next
			end

			#puts post.materials.split(',')
			ms = post.materials.split(',')
			ms.each do |m|
				m = m.strip
				if !@materials.include?(m)
					@materials.add?(m)
				end
			end
		end

		separate_demand_supply
	end

	def location
		puts "PARAMS " 
		puts params
		material = session[:material]
		puts material
		materials = []
		materials <<  material
		#materials.delete_at(0)
		location = params[:format]
		if location == nil
			location = 'All'
		end

        query materials, location
	end

	def refresh
		material = params[:post][:materials]
		materials = []
		materials <<  material
		#materials.delete_at(0)
		location = params[:post][:commit]
		@key = location
		if location == nil || location == 'GO'
			location = 'All'
		end
        session[:material] = material
        query materials, location
	end

	def query(materials, location)
		#material = params[:material]
		#location = params[:location]
		material = materials[0]
		@posts = []
		#if materials.index("All") == nil
		#	material = 'not_all'
		#end

		if material != 'All' && location != 'All'
			@posts = Post.getByLocationsAndMaterials(location, materials)
		elsif material == 'All' && location != 'All'
			@posts = Post.getByLocation(location)
		elsif material != 'All' && location == 'All'
			@posts = Post.getByMaterial(material)
		else
			index
		end

		@locations = Set.new

		@posts.each do |post|
			#next if post.location == nil
			#puts post.location.split(',')
			if post.location != nil
				ls = post.location.split(',')
				ls.each do |l|
					l = l.strip
					if !@locations.include?(l)
						@locations.add?(l)
					end
				end
			end
		end

		separate_demand_supply
	end

	def create
		post = Post.new
		post.action = params[:action]
		post.feedText = params[:feedText]
		post.location = params[:locations]
		post.materials = params[:materials]
		post.save
	end

	private 

	def separate_demand_supply
		@demand = []
		@supply = []
		#puts @posts.count
		@posts.each do |post|
			#puts post
			if post.action == 0
				@demand << post
			else
				@supply << post
			end
		end 
	end

end
