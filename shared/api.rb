module Api
  def self.host
    Settings.api_host.chomp("/")
  end

  def self.api_prefix
    "/api/v#{Settings.api_current_version}"
  end

  def self.get(path, &block)
    path = [api_prefix, path].join("/")
    client.get(path, &block)
  end

  def self.get_all_hexagrams
    get("/hexagrams") do |result|
      if result.success?
        hexagrams = {}
        result.object.each do |(n, h)|
          hexagrams[n.to_i] = h
        end
        Turnkey.archive(hexagrams, "hexagrams")
      else
        mp result.error.localizedDescription
      end
    end
  end

  def self.client
    @client ||= AFMotion::Client.build(host) do
      header "Accept", "application/json"
      header "X-Api-Version", Settings.api_current_version

      response_serializer :json
    end
  end
end
