# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DestroyMovie::EntryPoint do
  subject { described_class.new(movie) }

  let!(:movie) { create(:movie) }

  it_behaves_like 'successfully deletes movie object'
end
