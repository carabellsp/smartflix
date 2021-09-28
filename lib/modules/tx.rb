# frozen_string_literal: true

module Tx
  include ActiveSupport::Configurable

  def self.tx
    ActiveRecord::Base.transaction
  end
end
