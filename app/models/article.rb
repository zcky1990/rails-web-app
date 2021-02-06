class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "articles"

  field :slug, type: String
  field :title, type: String
  field :content, type: String
  field :modified_date, type: Date
  field :is_publish, type: Boolean, default: false

  belongs_to :web_meta, :class_name => "WebMeta"
  has_many :category, :class_name => "Category"
  belongs_to :created_by, :class_name => "User", optional: true
  belongs_to :moderated_by, :class_name => "User", optional: true

  index({ slug: 1 })
  index({ slug: 1, is_publish: 1 })
end
