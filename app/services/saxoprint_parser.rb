require 'mechanize'

class SaxoprintParser
  def initialize(parse_url = nil)
    @agent = Mechanize.new
    @page = @agent.get(parse_url)
    @session_id = @page.parser.css("#ShopContainer #tabSessionId").text
    @product_group = @page.parser.css("#ShopContainer #ProductGroupHf").text
  end

  def get_product_price
    @price = get_json["price"]["CustomerGrossValue"]
  end

  def get_product_title
    @title = @page.parser.css("#ShopContainer .shopheadline h1").text.strip
  end

  private

    def send_ajax_request
      ajax_headers = { 'X-Requested-With' => 'XMLHttpRequest', 
        'Content-Type' => 'application/json; charset=utf-8', 
        'Accept' => 'application/json, text/javascript, */*'}
      params = { productGroup: @product_group, 
                 switchableProductGroups: [@product_group],
                 tabSessionId: @session_id }.to_json
      @agent.post("http://www.saxoprint.de/print.svc/Init", params, ajax_headers)
    end

    def get_json
      json = send_ajax_request
      json = JSON.parse(json.body)["d"]
      json = JSON.parse(json)
    end
end