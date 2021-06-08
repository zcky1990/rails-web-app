class ProductSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :product_category_id
  attribute :product_category_name
  attribute :price
  attribute :available_add_on
  attribute :stock
  attribute :status
  attribute :is_active

  attribute :moderated_by
  attribute :updated_at

  def id
    object.id.to_s
  end

  def moderated_by
    if object.moderated_by.present?
      object.moderated_by.first_name + " " + object.moderated_by.last_name
    end
  end

  def status
    object.is_active ? "Active" : "Inactive" rescue "Inactive"
  end

  def product_category_id
    if object.product_category.category.present?
      object.product_category.category.id.to_s
    end
  end

  def price
    new_prices = []
    prices = object.price
    prices.each do |price|
      data = {
        price_type_id: price.price_type.id.to_s,
        price_type_name: price.price_type.name,
        price: price.price
      }
      new_prices << data
    end
    return new_prices
  end

  def available_add_on
    new_add_on = []
    available_add_on = object.available_add_on
    available_add_on.each do |addon|
      data = {
        add_on_id: addon.add_on.id.to_s,
        add_on_name: addon.add_on.name,
        price: addon.add_on.price
      }
      new_add_on << data
    end
    return new_add_on
  end

  def product_category_name
    if object.product_category.category.present?
      object.product_category.category.name
    end
  end

  def updated_at
    object.updated_at.strftime("%d/%m/%Y")
  end
end
