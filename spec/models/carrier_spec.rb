# frozen_string_literal: true

RSpec.describe Carrier do
  let(:washington) { locations(:washington) }
  let(:lancaster) { locations(:lancaster) }
  let(:category) { categories(:category) }

  it 'is valid with valid attributes' do
    expect(described_class.new(
      item_id: 1,
      name: 'test name',
      manufacturer: 'apple',
      model: 'iCarry',
      color: 'blue',
      home_location_id: washington.id,
      current_location: lancaster,
      category_id: category.id
    )).to be_valid
  end

  it "should have a photo attached" do
    carrier = Carrier.new
    file = Rails.root.join('public', 'apple-touch-icon.png')
    carrier.photos.attach(io: File.open(file), filename: 'apple-touch-icon.png')
    assert carrier.photos.attached?
  end

  it 'is not valid without an item_id' do
    expect(described_class.new(item_id: nil)).to_not be_valid
  end

  it 'is not valid without a name' do
    expect(described_class.new(name: nil)).to_not be_valid
  end

  it 'is not valid without a manufacturer' do
    expect(described_class.new(manufacturer: nil)).to_not be_valid
  end

  it 'is not valid without an model' do
    expect(described_class.new(model: nil)).to_not be_valid
  end

  it 'is not valid without a color' do
    expect(described_class.new(color: nil)).to_not be_valid
  end

  it 'is not valid without a home_location_id' do
    expect(described_class.new(home_location_id: nil)).to_not be_valid
  end

  it 'is not valid without a current_location_id' do
    expect(described_class.new(current_location_id: nil)).to_not be_valid
  end

  describe '#build_loan' do
    let(:carrier) { described_class.first }

    context "without parameters" do
      subject { carrier.build_loan }

      it 'creates a loan with the default due date set' do
        expect(subject.due_date).to eq Date.today + carrier.default_loan_length_days.days
      end
    end
  end
end
