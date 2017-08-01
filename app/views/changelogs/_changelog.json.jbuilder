json.extract! changelog, :id, :dnsname, :ipaddress, :typeanswer, :created_at, :updated_at
json.url changelog_url(changelog, format: :json)
