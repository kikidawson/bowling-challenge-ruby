# frozen_string_literal: true

require 'scorecard'

describe Scorecard do
  let(:subject) { described_class.new }

  it 'begins with an empty scorecard' do
    expect(subject.frames).to eq []
  end

  it 'takes two rolls and saves them to frame' do
    subject.roll(3)
    subject.roll(4)

    expect(subject.frames).to eq [[3, 4]]
  end

  it 'takes frame points and stores them' do
    subject.roll(3)
    subject.roll(4)
    subject.roll(2)
    subject.roll(5)

    expect(subject.frames).to eq [[3, 4], [2, 5]]
  end

  it 'adds the frame points to regular total' do
    subject.roll(3)
    subject.roll(4)
    subject.roll(2)
    subject.roll(5)

    expect(subject.regular_total).to eq 14
  end

  it 'saves strike in frame alone' do
    subject.roll(10)

    expect(subject.frames).to eq [[10]]
  end

  it 'strike bonus points - next two rolls double points' do
    subject.roll(10)
    subject.roll(2)
    subject.roll(6)

    expect(subject.total).to eq 26
  end

  it 'spare bonus points - next roll double points' do
    subject.roll(5)
    subject.roll(5)
    subject.roll(2)
    subject.roll(6)

    expect(subject.total).to eq 20
  end

  it 'double strike tester' do
    subject.roll(10)
    subject.roll(10)
    subject.roll(2)
    subject.roll(6)

    expect(subject.total).to eq 48
  end

  it 'testing ten frames' do
    subject.roll(1)
    subject.roll(4)
    subject.roll(4)
    subject.roll(5)
    subject.roll(6)
    subject.roll(4)
    subject.roll(5)
    subject.roll(5)
    subject.roll(10)
    subject.roll(0)
    subject.roll(1)
    subject.roll(7)
    subject.roll(3)
    subject.roll(6)
    subject.roll(4)
    subject.roll(10)
    subject.roll(2)
    subject.roll(4)

    expect(subject.total).to eq 119
  end

  it 'testing ten frames with spare last frame' do
    subject.roll(1)
    subject.roll(4)
    subject.roll(4)
    subject.roll(5)
    subject.roll(6)
    subject.roll(4)
    subject.roll(5)
    subject.roll(5)
    subject.roll(10)
    subject.roll(0)
    subject.roll(1)
    subject.roll(7)
    subject.roll(3)
    subject.roll(6)
    subject.roll(4)
    subject.roll(10)
    subject.roll(2)
    subject.roll(8)
    subject.roll(6)

    expect(subject.total).to eq 133
  end

  it 'perfect game - all strikes' do
    subject.roll(10)
    subject.roll(10)
    subject.roll(10)
    subject.roll(10)
    subject.roll(10)
    subject.roll(10)
    subject.roll(10)
    subject.roll(10)
    subject.roll(10)
    subject.roll(10)
    subject.roll(10)
    subject.roll(10)

    expect(subject.total).to eq 300
  end
end
