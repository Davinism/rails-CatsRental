class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: ["PENDING","APPROVED", "DENIED"] }
  validate :start_date_before_end_date
  validate :no_overlapping_approved_requests

  belongs_to :cat

  def start_date_before_end_date
    unless self.end_date > self.start_date
      self.errors[:start_date] << "cannot be greater than end date."
    end
  end

  def overlapping_requests
    CatRentalRequest
    .where.not("cat_rental_requests.cat_id != ? OR (cat_rental_requests.start_date > ? OR cat_rental_requests.end_date < ?)", self.cat_id, self.end_date, self.start_date)
    .where.not("cat_rental_requests.id = ?", self.id)
  end

  def overlapping_approved_requests
    self.overlapping_requests.where("cat_rental_requests.status = ?", "APPROVED")
  end

  def no_overlapping_approved_requests
    unless self.overlapping_approved_requests.empty?
      self.errors[:request] << "cannot overlap with an approved request"
    end
  end

  def approve!
    self.update(status: "APPROVED")
    self.overlapping_pending_requests.each { |request| request.deny! }
  end

  def overlapping_pending_requests
    self.overlapping_requests.where("cat_rental_requests.status = ?", "PENDING")
  end

  def deny!
    self.update(status: "DENIED")
  end

end
