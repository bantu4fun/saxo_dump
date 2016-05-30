class HomeController < ApplicationController
  def index
    if params[:parse_url]
      saxo_parser = SaxoprintParser.new(params[:parse_url])
      @product_price = saxo_parser.get_product_price
      @product_title = saxo_parser.get_product_title
    end
  end
end
