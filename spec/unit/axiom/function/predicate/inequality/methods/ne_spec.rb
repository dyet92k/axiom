# encoding: utf-8

require 'spec_helper'
require File.expand_path('../fixtures/classes', __FILE__)

describe Function::Predicate::Inequality::Methods, '#ne' do
  subject { object.ne(other) }

  let(:object)          { described_class.new.freeze     }
  let(:described_class) { InequalityMethodsSpecs::Object }
  let(:other)           { true                           }

  it { should be_instance_of(Function::Predicate::Inequality) }

  its(:left) { should be(object) }

  its(:right) { should be(other) }
end
