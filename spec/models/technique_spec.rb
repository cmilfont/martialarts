# encoding: UTF-8
require 'spec_helper'

describe Technique do
  
  describe "Relationships" do
    it { should belong_to :user }
    it { should have_and_belong_to_many :categories }
    it { should have_and_belong_to_many :martialarts }
    it { should have_many :videos }
  end
  
  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
  end
  
end
