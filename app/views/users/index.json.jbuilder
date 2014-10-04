json.array!(@users) do |user|
  json.extract! user, :id, :name, :sex, :birth, :email
  json.url user_url(user, format: :json)
end
