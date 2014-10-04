json.array!(@messages) do |message|
  json.extract! message, :id, :msg_code, :message, :upd_uid
  json.url message_url(message, format: :json)
end
