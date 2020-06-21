#!/usr/bin/env ruby
require_relative '../lib/rscan.rb'
main = nil

class MainScan < Rscan
  def self.something(path_file)
    Rscan.scan_file(path_file)
  rescue Errno::ENOENT
    puts 'No such file or directory'
    MainScan.new([''])
  end
end

loop do
  print 'Enter the path file: '
  path_file = gets.chomp
  main = MainScan.something(path_file)
  break if !main.file.length.zero? && !main.file[0].length.zero?
end

main.linter_on
main.linter_err.each { |key, value| puts "Line #{key}:  #{value}" }
