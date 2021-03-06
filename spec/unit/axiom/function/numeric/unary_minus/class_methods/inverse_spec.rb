# encoding: utf-8

require 'spec_helper'

describe Function::Numeric::UnaryMinus, '.inverse' do
  subject { object.inverse }

  let(:object) { described_class }

  it_should_behave_like 'an invertible method'

  it { should be(Function::Numeric::UnaryPlus) }
end
