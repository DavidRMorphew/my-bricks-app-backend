class LegoSetSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :image_url, :instructions_url, :year, :owned, :potential_build, :total_bricks, :set_number, :id
end
