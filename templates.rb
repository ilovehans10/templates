#!/usr/bin/env ruby

require("fileutils")

Helpmessage = "Usage: templates [OPTION] TEMPLATE

Arguments:
  -h    display this help
  -d    increase debug level
  -r    run default setup for filetype
  -D    dry run following commands"
Templateloc = "#{Dir.home}/.cache/templates/"

# Allows case to use include
def ===(value)
  include?(value)
end

# Copy function to move files
def copy(source, destination)
  print "dryrun = #{$dryrun} " if $debug >= 1
  # If in dryrun mode it will print files to copy and where they will be coppied to
  if $dryrun
    if source.class == [].class
      puts "Copy #{source.join(", ")} to #{FileUtils.pwd}"
    elsif source.class == "".class
      puts "Copy #{source} to #{FileUtils.pwd}"
    end
  else
    FileUtils.cp(source, FileUtils.pwd)
  end
end

p ARGV if ARGV[0].include?("d")
$debug = 0
$run = false
$dryrun = false
# Loop through arguments
while ARGV.length > 0
  current = ARGV.shift
  if current.include?"-"
    current = current.split("")
    current.shift
    # Loop through flags
    while current.length > 0
      flag = current.shift
      print "flag:#{flag} " if $debug >= 1
      case flag
      when "d"
        $debug += 1
        print "flag:#{flag} " if $debug == 1
        puts "debug = #{$debug} " if $debug >= 1
      when "h"
        puts Helpmessage
      when "r"
        $run = true
        puts "run = #{$run} " if $debug >= 1
      when "D"
        $dryrun = true
        puts "dryrun = #{$dryrun} " if $debug >= 1
      end
    end

  else
    case current.downcase
    when ["ruby", "gemfile"]
      copy(["#{Templateloc}Gemfile", "#{Templateloc}Gemfile.lock"], ".")
    end
  end
end
