module Spree
  class TaxonsController < Spree::StoreController
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    helper 'spree/products'

    respond_to :html

    def show
      @taxon = Taxon.find_by_permalink!(params[:id])
      return unless @taxon

      @searcher = build_searcher(params.merge(:taxon => @taxon.id))
      @products = @searcher.retrieve_products
      
#      min, max = @products.active.all.inject([]){|res,product| product.prices.each{|price| res << price.amount}; res}.minmax
      min_range, max_range = @products.active.all.map(&:price).minmax
      gon.max_price = max_range.ceil
      if params[:min_price] && params[:max_price]
        min_price = params[:min_price].to_i
        max_price = params[:max_price].to_i
        @products = @products.active.all.select{|x| x.price >= min_price && x.price <= max_price}
      end
    end

    private

    def accurate_title
      if @taxon
        @taxon.seo_title
      else
        super
      end
    end

  end
end
