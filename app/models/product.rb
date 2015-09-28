
class Product < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  belongs_to :type
  belongs_to :color
  belongs_to :style
  belongs_to :manufacturer

  before_destroy :destroy_parents


  has_one :technical_feature, dependent: :destroy
  accepts_nested_attributes_for :technical_feature

  has_many :placings
  has_many :recommended_places, through: :placings

  has_many :orders

  validates_presence_of(:name)
  validates_presence_of(:price)
  validates :price, numericality: {greater_than_or_equal_to: 0.01}


  def self.import_xls(file)
    new_path_to_uploaded_file = Rails.root.join('public', 'uploads', file.original_filename)

    File.open(new_path_to_uploaded_file, 'wb') do |new_file|
      new_file.write(file.read)
    end
    sheet = open_spreadsheet(new_path_to_uploaded_file).sheet(0)

    new_records = Array.new

    sheet.each(header_hash) do |current_row|
       if check_spreadsheet_row current_row
         new_records << create_record_from(current_row)
       end
    end

    new_records
  end

  def self.open_spreadsheet(file)
    Roo::Spreadsheet.open(file, extension: :xlsx)
  end


  def set_parents(parents_params)
    set_color(parents_params[:color])
    set_type(parents_params[:type])
    set_manufacturer(parents_params[:manufacturer])
    set_style(parents_params[:style])

    set_placing(parents_params[:places])
  end

  private

  def self.check_spreadsheet_row(row)

    return false if row[:name] == 'Название' # It's a bird! It's a plain! It's a cloud! It's a SuperCrutch!

    return true

  end

  def self.create_record_from(row)

    product_attributes = {
        name: row[:name],
        description: row[:description],
        price: row[:price],
        article_number: row[:article_number],

        technical_feature_attributes: {
            cap_type: row[:cap_type],
            lamp_type: row[:lamp_type],
            height: row[:height],
            width: row[:width],
            length: row[:length],
            diameter: row[:diameter],
            amount_of_lamps: row[:amount_of_lamps],
            one_lamp_power: row[:one_lamp_power],
            total_power: row[:total_power],
            illum_area: row[:illum_area]
        }
    }

    product_attributes[:remote] = row[:remote] == 'да' ? true : false

    product = self.new(product_attributes)
    product.set_parents row.slice(:type, :style, :manufacturer, :color, :places)
    product.save

    return product.id
  end

  def self.header_hash

    return {
        name: 'Название',
        description: 'Описание',
        price: 'Цена',
        article_number: 'Артикул',
        remote: /Пульт/,
        color: /Цвет/,
        type: /Тип/,
        style: /Стиль/,
        manufacturer: 'Производитель',
        places: /[Пп]омещен/,

        cap_type: /[Цц]окол/,
        lamp_type: 'Тип лампы',
        height: /[Вв]ысота/,
        width: /[Шш]ирина/,
        length: /[Дд]линна/,
        diameter: /[Дд]иаметр/,
        amount_of_lamps: 'Количество ламп',
        one_lamp_power: /[Мм]ощность лампы/,
        total_power: /[Мм]ощность общая/,
        illum_area: /[Пп]лощадь освещ/
    }

  end

  def parse_technical_feature(header)

  end

  # parents destruction

  def destroy_parents
    destroy_parent_object_if_possible('type', self.type)
    destroy_parent_object_if_possible('color', self.color)
    destroy_parent_object_if_possible('style', self.style)
    destroy_parent_object_if_possible('manufacturer', self.manufacturer)

    destroy_placings
  end

  def destroy_parent_object_if_possible(property_name, property_object)
    if property_object
      if Product.where(property_name => property_object).size == 1

        last_one = Product.where(property_name => property_object).take
        if last_one == self
          property_object.destroy!
        end

      end
    end
  end

  def destroy_placings
    Placing.where(product: self).each do |placing|
      placing.destroy
    end
  end

  # -----------------------------------

  # specific setters
  def set_color(color)
    self.color = Color.find_or_create_by(name: color)
  end

  def set_type(type)
    type = ::Type.find_or_create_by(name: type)
    self.type = type
  end

  def set_style(style)
    self.style = Style.find_or_create_by(name: style)
  end

  def set_manufacturer(manufacturer)
    self.manufacturer = Manufacturer.find_or_create_by(name: manufacturer.split.first)
    manufacturer[/\((.*?)\)/]
    set_country($1)
  end

  def set_country(country)
    self.manufacturer.country = Country.find_or_create_by(name: country)
    self.manufacturer.save
  end

  def set_placing(places)

    places_array = places.split ', '

    places_array.each do |place_name|
      place = Placing.new
      place.product = self
      place.recommended_place = RecommendedPlace.find_or_create_by(name: place_name)
      place.save
    end
  end

end
