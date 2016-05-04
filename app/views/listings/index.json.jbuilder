json.array!(@listings) do |listing|
  json.extract! listing, :id, :name, :description, :languages, :job_type
  json.url listing_url(listing, format: :json)
end
