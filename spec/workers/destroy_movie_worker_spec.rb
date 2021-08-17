# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DestroyMovieWorker do
  subject { described_class.new }

  before do
    freeze_time
  end

  context 'when a movie was updated within the last 48 hours' do
    before do
      create(:movie, title: 'Shrek', updated_at: 12.hours.ago)
    end

    it 'does not call the DestroyMovie::EntryPoint' do
      expect(DestroyMovie::EntryPoint).to_not receive(:new)

      subject.perform
    end

    it 'does not delete a movie from the database' do
      expect { subject.perform }.not_to change(Movie, :count)
    end
  end

  context 'when a movie was updated more than 48 hours ago' do
    before do
      create(:movie, title: 'The Notebook', updated_at: 72.hours.ago)
    end

    it 'calls DestroyMovie::EntryPoint' do
      expect(DestroyMovie::EntryPoint).to receive(:new)

      subject.perform
    end

    it 'deletes the movie from the database' do
      expect { subject.perform }.to change(Movie, :count).by(-1)
    end
  end
end
