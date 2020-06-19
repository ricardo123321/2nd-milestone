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

  describe '#space_inside_par' do
    let(:line1) { 'num = ( num / 234 ) ** 44' }
    let(:line2) { "nom = (1 + 2)" }
    it 'shows the changes in the linter error' do
      expect { file.space_inside_par(0, line1) }.to change(file, :linter_err)
      expect(file.linter_err[1]).to eql('Whitespace inside after parentheses, brackets or braces')
    end
    it "Return nil if the line don't have space inside of parentheses, brackets or braces" do
      expect { file.space_inside_par(0, line2) }.not_to change(file, :linter_err)
      expect(file.linter_err[1]).to eql(nil)
    end
  end
end