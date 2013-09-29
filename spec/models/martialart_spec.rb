require 'spec_helper'

describe Martialart do
  
  describe "Relationships" do
    it { should have_and_belong_to_many :techniques }
  end
  
  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
  end
  
  
end
