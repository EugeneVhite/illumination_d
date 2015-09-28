require 'spec_helper'

describe Product do

  describe '#validation' do
    it 'should have a valid factory' do
      expect(create(:product)).to be_valid
    end

    it 'should not be valid without name' do
      expect(build(:product, name: nil)).not_to be_valid
    end

    it 'should not be valid without price' do
      expect(build(:product, price: nil)).not_to be_valid
    end

    it 'should have positive price' do
      expect(build(:product, price: -1.02)).not_to be_valid
      expect(build(:product, price: 2.49)).to be_valid
    end

    it 'should have price more then 0.01' do
      expect(build(:product, price: 0)).not_to be_valid
      expect(build(:product, price: 3.95)).to be_valid
      expect(build(:product, price: 0.001)).not_to be_valid
    end
  end

  # Almost functional tests

  it 'should destroy associated technical features' do
    tech_f = create(:technical_feature)
    product = tech_f.product
    product.destroy!

    expect(TechnicalFeature.exists?(tech_f.id)).not_to be_truthy
  end

  describe '#destroy_parent_objects_if_possible' do


    it 'should destroy parents' do

      product = create(:product)

      # create parents for product and store it in local variables
      color = product.color = create(:color)
      type = product.type = create(:type)
      manufacturer = product.manufacturer = create(:manufacturer)
      style = product.style = create(:style)

      product.save

      # search in database by record's id
      expect(Type.exists?(type.id)).to be true
      expect(Style.exists?(style.id)).to be true
      expect(Manufacturer.exists?(manufacturer.id)).to be true
      expect(Color.exists?(color.id)).to be true

      product.destroy

      expect(Type.exists?(type.id)).to be false
      expect(Style.exists?(style.id)).to be false
      expect(Manufacturer.exists?(manufacturer.id)).to be false
      expect(Color.exists?(color.id)).to be false
    end



    it 'should destroy parents only with last record\'s destruction' do
      color = create(:color)
      style = create(:style)
      manufacturer = create(:manufacturer)
      type = create(:type)

      # parents for two products

      first_product = create(:product)
      second_product = create(:product)

      first_product.type = second_product.type = type
      first_product.color = second_product.color = color
      first_product.manufacturer = second_product.manufacturer = manufacturer
      first_product.style = second_product.style = style

      first_product.save
      second_product.save

      # destroy first

      first_product.destroy

      expect(Type.exists?(type.id)).to be true
      expect(Style.exists?(style.id)).to be true
      expect(Manufacturer.exists?(manufacturer.id)).to be true
      expect(Color.exists?(color.id)).to be true

      # destroy second

      second_product.destroy

      expect(Type.exists?(type.id)).to be false
      expect(Style.exists?(style.id)).to be false
      expect(Manufacturer.exists?(manufacturer.id)).to be false
      expect(Color.exists?(color.id)).to be false

    end

    it 'should destroy recommended places' do

      product_first = create(:product)
      product_second = create(:product)

      # in fact this is unreal without connection with product
      living_room = create(:recommended_place, name: 'living_room')
      kitchen = create(:recommended_place, name: 'kitchen')
      bedroom = create(:recommended_place, name: 'bedroom')

      # create connection
      create(:placing, product: product_first, recommended_place: living_room)
      create(:placing, product: product_first, recommended_place: kitchen)

      create(:placing, product: product_second, recommended_place: kitchen)
      create(:placing, product: product_second, recommended_place: bedroom)


      expect(Placing.all.count).to equal 4
      expect(Placing.where(product: product_first).count).to equal 2
      expect(Placing.where(product: product_second).count).to equal 2

      expect(living_room.products.count).to equal 1
      expect(kitchen.products.count).to equal 2
      expect(bedroom.products.count).to equal 1


      product_first.destroy

      # on destruction product should destroy all connected placings
      # destruction of recommended places implemented in Placing class (app/models/placing.rb)
      expect(Placing.where(product_id: product_first.id).count).to equal 0
      expect(RecommendedPlace.exists?(living_room.id)).to be false
      expect(RecommendedPlace.exists?(kitchen.id)).to be true

      product_second.destroy

      expect(Placing.all.count).to equal 0
      expect(RecommendedPlace.exists?(kitchen.id)).to be false
      expect(RecommendedPlace.exists?(bedroom.id)).to be false

    end


  end
end
