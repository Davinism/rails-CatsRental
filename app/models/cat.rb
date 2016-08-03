class Cat < ActiveRecord::Base
  COLORS = ["red", "pink", "black", "white"]
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: ["M", "F"] }

  has_many :cat_rental_requests, dependent: :destroy

  def age
    now = Time.now.utc.to_date
    now.year - birth_date.year - (birth_date.to_date.change(:year => now.year) > now ? 1 : 0)
  end


end
