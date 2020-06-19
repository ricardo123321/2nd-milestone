require_relative '../lib/rscan.rb'
require 'rspec'

RSpec.describe Rscan do
  let(:file) { Rscan.scan_file('test.rb') }
  describe '#scan_file' do
    it 'Return array with the lines of the file' do
      expect(file.file[0]).to eql('x = [    1, 2]')
      expect(file.file[-1]).to eql(' front = "something"')
    end
  end
end