require 'spec_helper'

describe Competition do
  
  it {should validate_presence_of :competition_name}
  it {should validate_presence_of :location}
  it {should validate_presence_of :city}
  it {should validate_presence_of :state}
  it {should validate_presence_of :time}
  it {should validate_presence_of :competition_details}
  it {should validate_presence_of :requirements}

  it {should respond_to :judges}

end

