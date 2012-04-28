#!/usr/bin/env ruby
#added caching - so might need to do this - http://github.com/netshade/cached_model
require File.expand_path('../../../config/boot',  __FILE__)
require File.expand_path('../../../config/environment',  __FILE__)
require 'builder'
xml = Builder::XmlMarkup.new( :target => $stdout, :indent => 2 )
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", 'xmlns:g' =>'http://base.google.com/ns/1.0' do
  xml.channel do
    xml.title "yourdomain.com Product Feed"
    xml.description "All the consumer goods from yourdomain - including electronics, optics, gifts, collectibles, collegiate memorabilia, games and many others..."
    xml.link 'http://yourodmain.com/'
    Product.find_in_batches(:batch_size => 100) do |results|
      results.each do |product|
        xml.item do 
          xml.title product.title
          xml.description product.description.gsub(/(\<br\/\>)|(\<br\>)/, '')
          xml.g :price do xml.text! product.price.to_s end
          xml.link 'http://yourdomain.com/products/' + product.to_param
          xml.g :id do xml.text! product.id.to_s end
          xml.g :condition do xml.text! 'new' end
          xml.g :weight do xml.text! product.weight.to_s + ' lb' end
          xml.g :brand do xml.text! product.manufacturer end
          xml.g :image_link do xml.text! product.image end
          xml.g :product_type do xml.text! product.category.display_name end
          xml.g :quantity do xml.text! '100' end
          xml.g :payment_accepted do xml.text! 'Visa' end
          xml.g :payment_accepted do xml.text! 'MasterCard' end
          xml.g :payment_accepted do xml.text! 'AmericanExpress' end
          xml.g :payment_accepted do xml.text! 'Discover' end
          xml.g :payment_accepted do xml.text! 'Paypal' end
          #xml.g :shipping do
          #  xml.g :country do xml.text! 'US' end
          #  xml.g :region  do xml.text! 'OR' end
          #  xml.g :service do xml.text! 'Ground' end
          #  xml.g :price do xml.text! 'NEEDS TO BE CALCED' end
          #end
          xml.g :tax do  
            xml.g :country do xml.text! 'US' end
            xml.g :region do xml.text! '97367' end
            xml.g :rate do xml.text! '8.25' end
            xml.g :tax_ship do xml.text! 'y' end
          end
        end
      end
    end
  end
end
