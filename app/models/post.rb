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
    Post.all
  end

  def self.getByLocation(location)
    l = '%' + location + '%'
    Post.where("location like ? and created_at > (NOW() - INTERVAL '12 hour')", l).order('created_at DESC').limit(50)
  end

  def self.getByLocations(locations)
    location = locations.join(' | ')
    Post.where("to_tsvector('english', location) @@ plainto_tsquery('english', ?) and created_at > (NOW() - INTERVAL '12 hour')",location).order('created_at DESC').limit(50)
    #Post.where()
  end

  def self.getByMaterials(materials)
    puts materials
    material = materials.join(' | ')
    Post.where("to_tsvector('english', materials) @@ plainto_tsquery('english', ?) and created_at > (NOW() - INTERVAL '12 hour')",material).order('created_at DESC').limit(50)
  end

  def self.getByMaterial(material)
    material = '%' + material + '%'
    #puts material
    Post.where("materials like ? and created_at > (NOW() - INTERVAL '12 hour')", material).order('created_at DESC').limit(50)
  end

  def self.getByLocationsAndMaterials(locations, materials)
    location = locations
    material = materials.join(' | ')
    Post.where("to_tsvector('english', location) @@ plainto_tsquery('english', ?) AND
                to_tsvector('english', materials) @@ plainto_tsquery('english', ?) and created_at > (NOW() - INTERVAL '12 hour')",
                location, material).order('created_at DESC').limit(50)
  end
end
