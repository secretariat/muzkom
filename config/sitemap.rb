# -*- encoding : utf-8 -*-
# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://muzkom.com.ua"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
    '/about_us'
    '/payment_delivery'
    '/publications'
    '/promotions'
    
    Publication.find_each do |article|
      add publication_path(article), :lastmod => article.updated_at
    end
    
    Promotion.find_each do |article|
      add promotion_path(article), :lastmod => article.updated_at
    end
    
    Product.find_each do |article|
      add product_path(article), :lastmod => article.updated_at
    end
    
    Subcategory.find_each do |article|
      add category_path(article), :lastmod => article.updated_at
    end
    
    Brand.find_each do |article|
      add brand_path(article), :lastmod => article.updated_at
    end
end
