require("fileutils")

Helpmessage = "This is the help message"
Templateloc = "$HOME/.cache/templates/"

# Allows case to use include
def ===(value)
  include?(value)
end

# Copy function to move files
def copy(source, destination)
  print "dryrun = #{$dryrun} " if $debug >= 1
  if $dryrun
    if source.class == [].class
      puts "Copy #{source.join(", ")} to #{FileUtils.pwd}"
    elsif source.class == "".class
      puts "Copy #{source} to #{FileUtils.pwd}"
    end
  else
    # FileUtils.cp
  end
end

p ARGV if ARGV[0].include?("d")
$debug = 0
$run = false
$dryrun = false
while ARGV.length > 0
  current = ARGV.shift
  if current.include?"-"
    current = current.split("")
    current.shift
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
