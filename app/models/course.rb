class Course < ActiveRecord::Base
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_image

  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :sections

  validates :title, :presence => true
  validates :description, :presence => true
  validates :price, :presence => true, :numericality => {:greater_than_or_equal_to => 0}

  def crop_image
    image.recreate_versions! if crop_x.present?
  end
end
