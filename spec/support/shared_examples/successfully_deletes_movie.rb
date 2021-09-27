# frozen_string_literal: true

RSpec.shared_examples 'successfully deletes movie object' do
  it 'deletes a movie object' do
    expect { subject }.to change(Movie, :count).by(-1)
  end
end

