require 'rails_helper'
RSpec.describe Book, type: :model do
    subject { FactoryBot.build(:book) }
  
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:ISBN) }
    it { is_expected.to validate_presence_of(:quantity_available) }
    it { is_expected.to validate_numericality_of(:quantity_available).is_greater_than_or_equal_to(0) }
  end
  