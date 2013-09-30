# encoding: UTF-8
require 'spec_helper'

describe Technique do
  
  describe "Relationships" do
    it { should belong_to :user }
    it { should have_many :martialart_techniques }
    it { should have_many(:martialarts).through :martialart_techniques }
    it { should have_many :videos }
  end
  
  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :user }
  end
  
end
