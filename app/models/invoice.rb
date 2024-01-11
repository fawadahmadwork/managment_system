class Invoice < ApplicationRecord

  include AASM
  attr_accessor :start_date_filter, :end_date_filter

  enum status: { initiated: 0, invoiced: 1, disbursed: 2, received: 3, canceled: 4, wont_proceed: 5 }

  aasm column: :status, no_direct_assignment: true, enum: true do
    state :initiated, initial: true
    state :invoiced
    state :disbursed
    state :received
    state :canceled
    state :wont_proceed

    event :invoiced do
      transitions from: [:initiated], to: :invoiced
    end

    event :disbursed do
      transitions from: [:invoiced], to: :disbursed
    end

    event :received do
      transitions from: [:disbursed], to: :received
    end

    event :canceled do
      transitions from: [:initiated, :invoiced, :disbursed], to: :canceled
    end

    event :wont_proceed do
      transitions from: [:initiated, :invoiced, :disbursed], to: :wont_proceed
    end
  end

	belongs_to :project
	belongs_to :weekly_hour, optional: true

end
