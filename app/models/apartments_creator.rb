require 'excelsior'

class ApartmentsCreator
  def initialize
    @apartments_in_csv = []
    @apartments = []
  end

  def apartments
    read_csv
    create_apartments

    @apartments
  end

  private

  def read_csv
    Excelsior::Reader.rows(File.open(Rails.root.join('apartments.csv'), 'rb')) do |row|
      @apartments_in_csv << { :location => row[0].force_encoding('UTF-8'), :surface => row[1], :cost => row[2] }
    end
  end

  def create_apartments
    @apartments_in_csv.each_with_index do |apartment_params, index|
      @apartments << Apartment.new(apartment_params.merge({ :id => index + 1 }))
    end
  end
end