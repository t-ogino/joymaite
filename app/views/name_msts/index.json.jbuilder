json.array!(@name_msts) do |name_mst|
  json.extract! name_mst, :id, :code_id, :code_id_name, :code, :name
  json.url name_mst_url(name_mst, format: :json)
end
