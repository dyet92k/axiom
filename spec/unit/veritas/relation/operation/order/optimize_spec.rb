require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#optimize' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = [ @relation[:id] ]
  end

  subject { @order.optimize }

  describe 'containing a relation' do
    before do
      @order = Relation::Operation::Order.new(@relation, @directions)
    end

    it { should equal(@order) }
  end

  describe 'containing an optimizable relation' do
    before do
      @projection = @relation.project(@relation.header)

      @order = Relation::Operation::Order.new(@projection, @directions)
    end

    it { should be_kind_of(Relation::Operation::Order) }

    it { subject.relation.should equal(@relation) }

    it { subject.directions.should == @directions }

    it 'should return the same tuples as the unoptimized operation' do
      should == @order
    end
  end

  describe 'containing an order operation' do
    before do
      @original = @relation.order([ @relation[:id].desc ])

      @order = Relation::Operation::Order.new(@original, @directions)
    end

    it { should be_kind_of(Relation::Operation::Order) }

    it { subject.relation.should equal(@relation) }

    it { subject.directions.should == @directions }

    it 'should return the same tuples as the unoptimized operation' do
      should == @order
    end
  end
end