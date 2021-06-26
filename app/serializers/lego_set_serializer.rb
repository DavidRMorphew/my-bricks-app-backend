class LegoSetSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :name, :image_url, :instructions_url, :year, :owned, :potential_build, :total_bricks, :set_number, :id, :theme_name
end
