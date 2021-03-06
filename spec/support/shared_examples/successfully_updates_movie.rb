# frozen_string_literal: true

RSpec.shared_examples 'successfully updates movie object' do
  it 'updates the movie object' do
    expect { subject }.to change(movie, :updated_at)
  end
end
