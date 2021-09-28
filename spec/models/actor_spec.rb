# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Actor, type: :model do
  subject do
    described_class.new(full_name: 'Cara Bell',
                        first_name: 'Cara',
                        last_name: 'Bell')
  end


  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'has the correct attributes' do
    expect(subject).to have_attributes(full_name: 'Cara Bell')
  end

  it 'is not valid without a first name' do
    subject.first_name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a last name' do
    subject.last_name = nil
    expect(subject).not_to be_valid
  end
end
