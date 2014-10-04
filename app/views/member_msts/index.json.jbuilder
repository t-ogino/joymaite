json.array!(@member_msts) do |member_mst|
  json.extract! member_mst, :id, :menber_no, :menber_name, :admission_date, :withdrawal_date, :birth_date, :enter_date, :marry_date, :memo, :del_flg
  json.url member_mst_url(member_mst, format: :json)
end
