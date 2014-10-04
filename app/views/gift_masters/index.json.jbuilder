json.array!(@gift_masters) do |gift_master|
  json.extract! gift_master, :id, :div, :condition, :condition_year, :amount, :year_flg
  json.url gift_master_url(gift_master, format: :json)
end
