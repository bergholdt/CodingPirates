class Entry < ApplicationRecord
  validates :pirat, presence: true, length: { maximum: 24 }
  validates :tekst, presence: true, length: { maximum: 280 }
end
