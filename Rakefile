require 'rake/rdoctask'
require 'rake/testtask'

desc "Run all tests"
task :default => [:test]

desc "Run all tests"
task :test do
  sh "specrb -Ilib:test -w #{ENV['TEST'] || '-a'} #{ENV['TESTOPTS']}"
end
