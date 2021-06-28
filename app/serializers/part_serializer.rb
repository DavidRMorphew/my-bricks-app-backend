class PartSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :part_number, :name, :color, :image_url, :id
end
