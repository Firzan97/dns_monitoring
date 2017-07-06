class Performance < ApplicationRecord
belongs_to :question, required: false

def self.total_on(date)
    where("date(created_at) = ?",date).sum(:responsetime)

  end
end
