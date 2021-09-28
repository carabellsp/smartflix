# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'scopes' do
    describe '.outdated' do
      subject { described_class.outdated }

      let(:movie1) { create(:movie, updated_at: 2.days.ago) }
      let(:movie2) { create(:movie, updated_at: 2.days.ago - 1.minute) }
      let(:movie3) { create(:movie, updated_at: 2.days.ago + 1.minute) }
      let(:movies) { [movie1, movie2, movie3] }

      it do
        freeze_time do
          movies

          expect(subject).to eq([movie2])
        end
      end
    end
  end

  context 'with correct attributes, movie is valid' do
    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).not_to be_valid
    end
  end
end
