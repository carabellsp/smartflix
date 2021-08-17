# frozen_string_literal: true

require 'rails_helper'
require_relative 'destroy_movie_shared_examples'

RSpec.describe DestroyMovie::Action do
  subject { described_class.new.call(movie) }

  let!(:movie) { create(:movie) }

  include_examples 'successfully deletes movie object'
end
