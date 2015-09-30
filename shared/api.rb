module Api
  def self.host
    Settings.api_host.chomp("/") + self.api_prefix
  end

  def self.api_prefix
    "/v#{Settings.api_current_version}/"
  end

  def self.get_all_hexagrams(&block)
    client.get("hexagrams") do |result|
      if result.success?
        block.call(result.object)
      else
        mp result.error.localizedDescription
      end
    end
  end

  def self.get_all_trigrams(&block)
    client.get("trigrams") do |result|
      if result.success?
        block.call(result.object)
      else
        mp result.error.localizedDescription
      end
    end
  end

  def self.cast_hexagram(method, &block)
    client.get ("hexagram.#{method}") do |result|
      if result.success?
        block.call(result.object)
      else
        mp result.error.localizedDescription
      end
    end
  end

  def self.get_judgement(king_wen_number, &block)
    client.get("hexagrams/#{king_wen_number}/judgement") do |result|
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
