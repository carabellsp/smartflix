# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DestroyMovie::Action do
  subject { described_class.new.call(movie) }

  let!(:movie) { create(:movie) }

  it_behaves_like 'successfully deletes movie object'
end
