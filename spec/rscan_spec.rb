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
    let(:line1) { 'num = ( num / 234) ** 44' }
    let(:line2) { 'nom = (1 + 2)' }
    let(:line3) { 'num = (num / 234 ) ** 44' }
    it 'shows the changes in the linter error after parentheses' do
      expect { file.space_inside_par(0, line1) }.to change(file, :linter_err)
      expect(file.linter_err[1]).to eql('Whitespace inside after parentheses, brackets or braces')
    end
    it 'shows the changes in the linter error after parentheses' do
      expect { file.space_inside_par(0, line3) }.to change(file, :linter_err)
      expect(file.linter_err[1]).to eql('Whitespace inside before parentheses, brackets or braces')
    end
    it 'return nil if theres no error' do
      expect { file.space_inside_par(0, line2) }.not_to change(file, :linter_err)
      expect(file.linter_err[1]).to eql(nil)
    end
  end

  describe '#space_inside_oper' do
    let(:line1) { 'x             = 450' }
    let(:line2) { 'x = 908' }
    let(:line3) { 'x =             450' }
    it 'shows the changes in the linter error before an operator' do
      expect { file.space_inside_oper(0, line1) }.to change(file, :linter_err)
      expect(file.linter_err[1]).to eql('Whitespace inside before an operator')
    end
    it 'shows the changes in the linter error before an operator' do
      expect { file.space_inside_oper(0, line3) }.to change(file, :linter_err)
      expect(file.linter_err[1]).to eql('Whitespace inside after an operator')
    end
    it 'return nil if theres no error' do
      expect { file.space_inside_oper(0, line2) }.not_to change(file, :linter_err)
      expect(file.linter_err[1]).to eql(nil)
    end
  end

  # rubocop:disable Layout/LineLength
  describe '#line_length' do
    let(:line1) { "print('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec libero ut mauris mattis varius vel et urna. Vivamus nec mauris quam. Donec eu metus nec enim ullamcorper fringilla. Morbi vitae ipsum ornare, luctus ipsum ac, facilisis est. Proin eget eros sit amet enim tristique ultricies vitae at metus. Suspendisse.')" }
    let(:line2) { "print('Hello World!')" }
    it 'shows the changes in the linter error when the line length is greater than 100' do
      expect { file.line_length(0, line1) }.to change(file, :linter_err)
    end
    it 'nothing happens if the length is less than 100' do
      expect { file.line_length(0, line2) }.not_to change(file, :linter_err)
    end
  end
  # rubocop:enable Layout/LineLength
  describe '#check_identation' do
    let(:line) { "   print('this is incorrect')" }
    let(:line2) { '  something:' }
    let(:line3) { '' }
    it 'shows the changes in the linter error when theres a wrong indentation level' do
      expect { file.check_identation(0, line) }.to change(file, :linter_err)
      expect(file.linter_err[1]).to eql('Wrong indentation level')
    end
    it 'Return nil if the indentation is correct' do
      expect { file.check_identation(0, line2) }.not_to change(file, :linter_err)
      expect(file.linter_err[1]).to eql(nil)
    end
    it 'Return nil if the line is empty' do
      expect { file.check_identation(0, line3) }.not_to change(file, :linter_err)
      expect(file.linter_err[1]).to eql(nil)
    end
  end
end
