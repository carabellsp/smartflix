# frozen_string_literal: true

module Tx
  include ActiveSupport::Configurable

  def tx
    ActiveRecord::Base.transaction
  end
end
