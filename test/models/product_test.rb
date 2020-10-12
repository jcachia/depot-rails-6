require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title: "Title", description: "Description", image_url: "image.jpg")
    
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
    
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
    
    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: "Title", description: "Description", price: 1, image_url: image_url)
  end

  test "image_url" do
    ok = %w{ fred.gif fred.jpeg fred.jpg fred.png FRED.JPG FRED.Jpg https://a.f.gh.a.com/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |url|
      assert new_product(url).valid?, "#{url} shouldn't be invalid"
    end

    bad.each do |url|
      assert new_product(url).invalid?, "#{url} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title" do
    assert products(:ruby).present? #Loaded from fixtures.
    product = Product.new(title: products(:ruby).title, description: "Description", price: 1, image_url: "image.jpg")
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end

end
