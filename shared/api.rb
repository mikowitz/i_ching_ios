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

  def self.get_all_hexagrams(&block)
    get("hexagrams") do |result|
      if result.success?
        block.call(result.object)
      else
        mp result.error.localizedDescription
      end
    end
  end

  def self.get_all_trigrams(&block)
    get("trigrams") do |result|
      if result.success?
        block.call(result.object)
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
