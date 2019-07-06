json.array!(@sanitizes) do |sanitize|
  json.extract! sanitize, :id, :match, :result, :description, :status
  json.url sanitize_url(sanitize, format: :json)
end
