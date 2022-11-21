require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should successfully save a product with all 4 fields' do 
      @category = Category.create(name: "Tropical")
      @product = Product.create(name: "Pilea", price_cents: 500, quantity: 10, category: @category)
      expect(@product.valid?).to be true
    end

    it 'should return an error if name is nil' do
      @category = Category.create(name: "Tropical")
      expect(@category).to be_present

      @product = Product.create(name: nil, price_cents: 500, quantity: 10, category: @category)
      expect(@product.valid?).not_to be true
      expect(@product.errors[:name]).to include ("can't be blank")
    end

    it 'should return an error if price is nil' do
      @category = Category.create(name: "Tropical")
      expect(@category).to be_present

      @product = Product.create(name: "Pilea", price_cents: nil, quantity: 10, category: @category)
      expect(@product.valid?).not_to be true
      expect(@product.errors.full_messages).to include ("Price can't be blank")
    end

    it 'should return an error if quantity is nil' do
      @category = Category.create(name: "Tropical")
      expect(@category).to be_present

      @product = Product.create(name: "Pilea", price_cents: 500, quantity: nil, category: @category)
      expect(@product.valid?).not_to be true
      expect(@product.errors[:quantity]).to include ("can't be blank")
    end

    it 'should return an error if category is nil' do
      @category = nil
      expect(@category).to be nil

      @product = Product.create(name: "Pilea", price_cents: 500, quantity: nil, category: @category)
      expect(@product.valid?).not_to be true
      expect(@product.errors[:category]).to include ("can't be blank")
    end
  end
end
