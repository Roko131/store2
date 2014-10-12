=begin
  
module Spree
  StoreController.class_eval do
    before_filter :set_locale
  end
  
  UserSessionsController.class_eval do
    before_filter :set_locale
  end
  
  Admin::BaseController.class_eval do
    before_filter :set_locale_to_en
  end
  
  module BaseHelper

    def taxons_tree(root_taxon, current_taxon, max_level = 1)
      return '' if max_level < 1 || root_taxon.children.empty?
      ul_css_class = root_taxon == current_taxon || ( current_taxon && root_taxon.id == current_taxon.parent_id) ? "taxons-list current-ul" : "taxons-list"
      content_tag :ul, class: ul_css_class do
        root_taxon.children.map do |taxon|
          css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'current' : nil
          content_tag :li, class: css_class do
           link_to(taxon.name, seo_url(taxon)) +
           taxons_tree(taxon, current_taxon, max_level - 1)
          end
        end.join("\n").html_safe
      end
    end
  end
  
  module ProductsHelper
    
      
    # converts line breaks in product description into <p> tags (for html display purposes)
    def product_description(product)
      sol = if Spree::Config[:show_raw_product_description]
        raw(product.description)
      else
        raw(product.description.gsub(/(.*?)\r?\n\r?\n/m, '<p>\1</p>'))
      end
      sol == "" ? Spree.t(:product_has_no_description) : sol
    end
  end
  
end
=end

[Spree::UserPasswordsController, Spree::UserRegistrationsController, Spree::UserSessionsController, Spree::CheckoutController, Spree::UsersController].each do |klass|  
    klass.class_eval do    
      helper 'spree/products'  
    end
 end