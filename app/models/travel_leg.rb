# == Schema Information
#
# Table name: travel_legs
#
#  id                   :integer          not null, primary key
#  travel_request_id    :integer
#  date_start           :datetime
#  date_end             :datetime
#  destination_address  :string(255)
#  destination_suburb   :string(255)
#  destination_city     :string(255)
#  destination_state    :string(255)
#  destination_postcode :string(255)
#  comment              :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  fully_booked         :boolean
#

class TravelLeg < ActiveRecord::Base
  belongs_to :travel_request
  has_many :flight
  has_many :car_hire
  has_many :accommodation
  has_and_belongs_to_many :user

  validates :date_start, presence: true
  validates :date_end, presence: true
  validates :destination_city, presence: true
  validates :destination_state, presence: true

  def flights_to_book
    @flights = self.flight
    @flights_to_book = 0
    @flights.each do |flight|
      if flight.booked == false
        @flights_to_book = @flights_to_book + 1
      end
    end
    @flights_to_book
  end

  def cars_to_book
    @cars = self.car_hire
    @cars_to_book = 0
    @cars.each do |car|
      if car.booked == false
        @cars_to_book = @cars_to_book + 1
      end
    end
    @cars_to_book
  end

  def accommodation_to_book
    @accommodations = self.accommodation
    @accommodations_to_book = 0
    @accommodations.each do |accommodation|
      if accommodation.booked == false
        @accommodations_to_book = @accommodations_to_book + 1
      end
    end
    @accommodations_to_book
  end

  def bookings_remaining
    self.flights_to_book + self.cars_to_book + self.accommodation_to_book
  end

  def leg_booked?
    if (self.flights_to_book + self.cars_to_book + self.accommodation_to_book) == 0
      true
    else
      false
    end
  end
end
