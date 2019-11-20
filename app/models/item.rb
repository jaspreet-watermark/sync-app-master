class Item
  include Mongoid::Document
  include Mongoid::Enum
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  # Fields
  field :title,        type: String
  field :description,  type: String
  field :failed,       type: Boolean, default: false
  field :due_at,       type: DateTime
  field :failed_at,    type: DateTime
  field :last_sync_at, type: DateTime
  field :started_at,   type: DateTime
  field :completed_at, type: DateTime

  enum :status, %i[prepared started completed], default: :prepared

  # scopes
  scope :failed, -> { where(failed: true) }

  # Associations
  embeds_many :tags

  # Validations
  validates :title,  presence: true
  validates :status, presence: true

  # callbacks
  after_save :process_status

  # class methods
  class << self
    def statuses
      STATUS.map(&:to_s)
    end
  end

  # instance methods
  def process_status
    if _status_changed?
      case status.to_sym
      when :started
        set(started_at: DateTime.now) unless started_at_changed?
      when :completed
        set(completed_at: DateTime.now) unless completed_at_changed?
      end
    end
  end
end

