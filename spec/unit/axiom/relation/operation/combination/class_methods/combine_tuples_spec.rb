# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Combination, '.combine_tuples' do
  subject do
    object.combine_tuples(
      header,
      left_tuple,
      right_tuples,
      &yields.method(:<<)
    )
  end

  let(:object)       { self.class.described_class                  }
  let(:header)       { left_header | right_header                  }
  let(:left_tuple)   { Tuple.new(left_header,  [1])                }
  let(:right_tuples) { [Tuple.new(right_header, ['Dan Kubb'])]     }
  let(:left_header)  { Relation::Header.coerce([[:id,   Integer]]) }
  let(:right_header) { Relation::Header.coerce([[:name, String]])  }
  let(:yields)       { []                                          }

  it 'yields each combined tuple' do
    expect { subject }.to change { yields.dup }
      .from([])
      .to([[1, 'Dan Kubb']])
  end
end
