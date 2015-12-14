class Post < ActiveRecord::Base
  #include PgSearch
  attr_accessible :action, :feedText, :location, :materials, :url, :source, :twitter_html

=begin
  def self.getAllSupplies
  	Post.where("action = ?", 0)
  end

  def self.getAllDemands
  	Post.where("action = ?", 1)
  end
=end
=begin
  def self.getDemandsByMaterial(material)
  	Post.where("action = ? AND material LIKE ?", 1, material)
  end

  def self.getSuppliesByMaterial(material)
  	Post.where("action = ? AND material LIKE ?", 0, material)
  end
=end

  def self.getAll()
    Post.select('DISTINCT ON (url,created_at) *').where("created_at > (NOW() - INTERVAL '48 hour')").order('created_at DESC')
  end

  def self.getByLocation(location)
    l = '%' + location + '%'
    Post.select('DISTINCT ON (url,created_at) *').where("location ilike ? and created_at > (NOW() - INTERVAL '48 hour')", l).order('created_at DESC')
  end

  def self.getByLocations(locations)
    location = locations.join(' | ')
    Post.select('DISTINCT ON (url,created_at) *').where("to_tsvector('english', location) @@ plainto_tsquery('english', ?) and created_at > (NOW() - INTERVAL '48 hour')",location).order('created_at DESC')
    #Post.where()
  end

  def self.getByMaterials(materials)
    puts materials
    material = materials.join(' | ')
    Post.select('DISTINCT ON (url,created_at) *').where("to_tsvector('english', materials) @@ plainto_tsquery('english', ?) and created_at > (NOW() - INTERVAL '48 hour')",material).order('created_at DESC')
  end

  def self.getByMaterial(material)
    material = '%' + material + '%'
    #puts material
    Post.select('DISTINCT ON (url,created_at) *').where("materials ilike ? and created_at > (NOW() - INTERVAL '48 hour')", material).order('created_at DESC')
  end

  def self.getByLocationsAndMaterials(locations, materials)
    location = locations
    material = materials.join(' | ')
    Post.select('DISTINCT ON (url,created_at) *').where("to_tsvector('english', location) @@ plainto_tsquery('english', ?) AND
                to_tsvector('english', materials) @@ plainto_tsquery('english', ?) and created_at > (NOW() - INTERVAL '48 hour')",
                location, material).order('created_at DESC')
  end
end
