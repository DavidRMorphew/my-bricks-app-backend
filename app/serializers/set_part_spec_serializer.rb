class SetPartSpecSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :lego_set_id, :part_id, :part_quantity
end
