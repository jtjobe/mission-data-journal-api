module ApiHelper
  def json
    JSON.parse(response.body)
  end
end

RSpec.configure do |c|
  c.include ApiHelper
end

