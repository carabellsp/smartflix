# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MoviesController do
  subject { described_class.new }

  describe 'get #show' do
    context 'when the movie is in the database' do
      let(:movie) { create(:movie) }

      it 'returns a movie as json' do
        get :show, params: { title: movie.title }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when movie is not in the database' do
      it 'returns an error' do
        expect(CreateMovieWorker).to receive(:perform_async)

        get :show, params: { title: 'Smartflixxxxxx' }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
