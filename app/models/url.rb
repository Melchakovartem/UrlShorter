class Url < ApplicationRecord
  validates :long, presence: true, uniqueness: true

  before_create :set_short_url

  def change_count_by_one
    self.match += 1
    save
  end

  private

  def set_short_url
    self.short = short_url
  end

  def short_url
    array_of_symbols = ((0..9).to_a + ('a'..'z').to_a)
    Array.new(20).map { array_of_symbols.sample }.join
  end
end
