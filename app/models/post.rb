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
    Post.where("location like '%?%'", location)
  end

  def self.getByLocations(locations)
    location = locations.join(' | ')
    Post.where("to_tsvector('english', location) @@ plainto_tsquery('english', ?) ",location)
    #Post.where()
  end

  def self.getByMaterials(materials)
    puts materials
    material = materials.join(' | ')
    Post.where("to_tsvector('english', materials) @@ plainto_tsquery('english', ?) ",material)
  end

  def self.getByMaterial(material)
    material = '%' + material + '%'
    #puts material
    Post.where("materials like ?", material)
  end

  def self.getByLocationsAndMaterials(locations, materials)
    location = locations
    material = materials.join(' | ')
    Post.where("to_tsvector('english', location) @@ plainto_tsquery('english', ?) AND
                to_tsvector('english', materials) @@ plainto_tsquery('english', ?)",
                location, material)
  end
end
