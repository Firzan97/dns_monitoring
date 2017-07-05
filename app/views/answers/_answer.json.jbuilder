json.extract! answer, :id, :dnsname, :ttl, :recordtype, :ipaddress, :created_at, :updated_at
json.url answer_url(answer, format: :json)
