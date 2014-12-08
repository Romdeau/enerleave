# == Schema Information
#
# Table name: travel_legs
#
#  id                :integer          not null, primary key
#  travel_request_id :integer
#  date_start        :datetime
#  date_end          :datetime
#  destination_city  :string(255)
#  comment           :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  fully_booked      :boolean
#  destination_type  :string(255)
#  booking_status    :string(255)
#

class TravelLeg < ActiveRecord::Base
  belongs_to :travel_request
  has_many :car_hire, dependent: :destroy
  has_many :accommodation, dependent: :destroy
  has_many :flight, dependent: :destroy
  has_and_belongs_to_many :user

  validates :date_start, presence: true
  validates :destination_city, presence: true

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

  def bookings_remaining
    self.cars_to_book + self.accommodation_to_book + self.flights_to_book
  end

  def leg_booked?
    if self.fully_booked == true
      true
    else
      false
    end
  end
end
