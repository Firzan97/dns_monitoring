json.extract! question, :id, :dnsname, :recordtype, :server, :created_at, :updated_at
json.url question_url(question, format: :json)
