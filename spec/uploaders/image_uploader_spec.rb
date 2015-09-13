require 'spec_helper'

Model = Class.new do
  ATTRS = %w(width height)
  attr_accessor *ATTRS.map(&:to_sym)

  def id; 42; end

  def attributes
    OpenStruct.new(keys: ATTRS)
  end

  def update(attrs)
    @width = attrs.fetch(:width)
    @height = attrs.fetch(:height)
  end
end

RSpec.describe ImageUploader do
  let(:placeholder_image) { 'spec/support/carrierwave_placeholder.png' }

  subject { ImageUploader.new(Model.new) }

  before do
    ImageUploader.enable_processing = true
    File.open(File.expand_path(placeholder_image)) do |image|
      subject.store!(image)
    end
  end

  context 'resizing' do
    context 'medium' do
      it 'scales down an image to 600x600' do
        expect(subject.medium).to be_no_larger_than(600, 600)
      end
    end

    context 'small' do
      it 'scales down an image to 300x300' do
        expect(subject.medium).to be_no_larger_than(600, 600)
      end
    end
  end

  context 'dimension persistence' do
    it 'persists the width' do
      expect(subject.model.width).to eq 1000
    end

    it 'persists the height' do
      expect(subject.model.height).to eq 1000
    end
  end
end
