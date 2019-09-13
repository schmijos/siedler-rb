# frozen_string_literal: true

require 'turn'

RSpec.describe Turn do
  subject(:turn) { described_class.new }

  it { is_expected.not_to be_nil }
end
