require 'spec_helper'

describe Martialart do
  
  describe "Relationships" do
    it { should have_many :martialart_techniques }
    it { should have_many(:techniques).through :martialart_techniques }
  end
  
  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
  end
  
end
