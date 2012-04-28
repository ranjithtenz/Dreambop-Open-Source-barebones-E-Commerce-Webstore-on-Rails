xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Buymeyo Product Feed"
    xml.description "All the consumer goods from buymeyo - including electronics, optics, gifts, collectibles, collegiate memorabilia, games and many others..."
    xml.link products_url
    for product in @products
      xml.item do
        xml.title product.title
        xml.description product.description.gsub(/(\<br\/\>)|(\<br\>)/, '')
        xml.price product.price
        xml.link product_url(product)
        xml.id product.id.to_s
        xml.condition 'new'
        xml.weight product.weight
        xml.brand product.manufacturer
        xml.image_link product.image
        xml.product_type product.category.display_name
        xml.quantity product.quantity
        xml.payment_accepted 'Visa'
        xml.payment_accepted 'MasterCard'
        xml.payment_accepted 'AmericanExpress'
        xml.payment_accepted 'Discover'
        xml.shipping do
          xml.country 'US'
          xml.region 'OR'
          xml.service 'Ground'
        end
        xml.tax do
          xml.country 'US'
          xml.region '97367'
          xml.rate '8.25'
          xml.tax_ship 'y'
        end
      end
    end
  end
end

