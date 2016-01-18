class Course < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_image

  belongs_to :user
  has_many :sections
  has_many :enrollments

  validates :title, :presence => true
  validates :description, :presence => true
  validates :price, :presence => true, :numericality => {:greater_than_or_equal_to => 0}

  def crop_image
    image.recreate_versions! if crop_x.present?
  end

  def free?
    price.zero?
  end

  def premium?
   ! free?
  end
end
