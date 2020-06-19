class Rscan
  attr_reader :file, :linter_err

  def initialize(file)
    @file = file
    @linter_err = {}
  end

  def self.scan_file(path_file)
    Rscan.new(IO.readlines(path_file, chomp: true))
  rescue Errno::ENOENT
    puts 'No such file or directory'
    Rscan.new([''])
  end

  def linter_on
    count = 0
    @file.each do |line|
      line_length(count, line)
      space_inside_par(count, line)
      space_inside_oper(count, line)
      check_identation(count, line)
      count += 1
    end
  end

  def space_inside_par(count, line)
    matches1 = ['(', '[', '{']
    matches2 = [')', ']', '}']
    num = 0
    line.split('').each do |char|
      if matches1.include?(char) && line[num + 1] == ' '
        @linter_err[count + 1] = 'Whitespace inside after parentheses, brackets or braces'
        break
      end
      if matches2.include?(char) && line[num - 1] == ' '
        @linter_err[count + 1] = 'Whitespace inside before parentheses, brackets or braces'
        break
      end
      num += 1
    end
  end

  def line_length(count, line)
    return unless line.length > 100
    
    @linter_err[count + 1] = "no allowed to have more than 100 characters on a line, you have #{line.length}"
  end

  def space_inside_oper(count, line)
    matches1 = ['+', '-', '*', '/', '**', '=']
    num = 0
    line.split('').each do |char|
      if matches1.include?(char) && (line[num + 1] + line[num + 2]) == '  '
        @linter_err[count + 1] = 'Whitespace inside after an operator'
        break
      end
      if matches1.include?(char) && (line[num - 1] + line[num - 2]) == '  '
        @linter_err[count + 1] = 'Whitespace inside before an operator'
        break
      end
      num += 1
    end
  end

  def empty?(line)
    return true if line.length.zero?

    false
  end

  def check_identation(count, line)
    return if empty?(line)
    count_space = 0
    line.split('').each do |char|
      break if char != ' '
      count_space += 1
    end
    @linter_err[count + 1] = 'Wrong indentation level' if count_space % 2 != 0
  end
end