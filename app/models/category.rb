class Category < ActiveRecord::Base
  acts_as_tree :order => "name"

  before_create :sanitize_name

  def self.url_safe(name)
    idn = name.gsub(/[^0-9A-Za-z]|[ ]+/, ' ')
    idn = idn.gsub(/[ ]+/, '+')
    return idn
  end

  def url_safe
    return Category.url_safe(self.name)
  end
  
  def linkify
    link = self.name.gsub(/[^0-9A-Za-z]|[ ]+/, ' ')
    link = link.gsub(/[ ]+|[\+]+/, '-')
    return link
  end

  def self.db_safe(name)
    idn = name.gsub(/[^0-9A-Za-z]|[ ]+/, ' ')
    idn = idn.gsub(/[\+|-]+/, ' ')
    return idn
  end

  def db_safe
    return Category.db_safe(self.name)
  end

  def sanitize_name
    self.name = Category.sanitize(self.name)
  end

  def self.sanitize(name)
    name = name.gsub(/[^0-9A-Za-z]|[ ]+/, ' ')
    name = name.gsub(/ +/, ' ')
    return name
  end

  def display_name
    self.name.gsub(/\+|-/, ' ')
  end

  def breadcrumb
    i = 0
    crumbs = []
    p = self
    until p == nil 
      crumbs[i] = p unless p.nil?
      p = p.parent
      i = i+ 1
    end
    return crumbs
  end

  def all_children
    all = []
    self.children.each do |category|
      all << category
      root_children = category.all_children.flatten
      all << root_children unless root_children.empty?
    end
    return all.flatten
  end
end
