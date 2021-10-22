class OwnedSetsSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :user_id, :lego_set_id, :id
end
