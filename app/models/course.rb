class Course < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :sections
  has_many :enrollments

  validates :title, :presence => true
  validates :description, :presence => true
  validates :price, :presence => true, :numericality => {:greater_than_or_equal_to => 0}

  def free?
    price.zero?
  end

  def premium?
   ! free?
  end
end
