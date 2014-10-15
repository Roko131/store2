class PagesController < ApplicationController
  helper ['spree/products', 'spree/base']
  helper_method ["current_currency"]
  
  include Spree::Core::ControllerHelpers::Search
  include Spree::Core::ControllerHelpers::Auth
  
  def test1
      @searcher = build_searcher(params)
      @products = @searcher.retrieve_products
  end

  def test2
  end
  
  private
  
  def current_currency
     Spree::Config[:currency]
  end
end
