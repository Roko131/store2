class PagesController < ApplicationController
  helper ['spree/products', 'spree/base']
  helper_method ["current_currency"]
  def test1
  end

  def test2
  end
  
  private
  
  def current_currency
     Spree::Config[:currency]
  end
end
