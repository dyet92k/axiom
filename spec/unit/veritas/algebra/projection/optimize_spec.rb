require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Projection#optimize' do
  before do
    @relation = Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ])
  end

  subject { @projection.optimize }

  describe 'when the attributes are equivalent to the relation headers, and in the same order' do
    before do
      @projection = Algebra::Projection.new(@relation, [ :id, :name ])
    end

    it { should equal(@relation) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @projection
    end
  end

  describe 'when the attributes are equivalent to the relation headers, and not in the same order' do
    before do
      @projection = Algebra::Projection.new(@relation, [ :name, :id ])
    end

    it 'should not factor out the projection, because tuple order is currently significant' do
      should equal(@projection)
    end
  end

  describe 'when the attributes are different from the relation headers' do
    before do
      @projection = Algebra::Projection.new(@relation, [ :id ])
    end

    it { should equal(@projection) }
  end

  describe 'containing an empty relation' do
    before do
      @empty = Relation::Empty.new(@relation.header)

      @projection = Algebra::Projection.new(@empty, [ :id ])
    end

    it { should be_kind_of(Relation::Empty) }

    it { subject.header.should == @projection.header }

    it 'should return the same tuples as the unoptimized operation' do
      should == @projection
    end
  end

  describe 'containing an empty relation when optimized' do
    before do
      @restriction = Algebra::Restriction.new(@relation, Algebra::Restriction::False.new)

      @projection = Algebra::Projection.new(@restriction, [ :id ])
    end

    it { should be_kind_of(Relation::Empty) }

    it { subject.header.should == @projection.header }

    it 'should return the same tuples as the unoptimized operation' do
      should == @projection
    end
  end

  describe 'containing an optimizable relation' do
    before do
      @restriction = Algebra::Restriction.new(@relation, Algebra::Restriction::True.new)

      @projection = Algebra::Projection.new(@restriction, [ :id ])
    end

    it { should be_kind_of(Algebra::Projection) }

    it { subject.relation.should equal(@relation) }

    it { subject.header.should == @projection.header }

    it 'should return the same tuples as the unoptimized operation' do
      should == @projection
    end
  end
end