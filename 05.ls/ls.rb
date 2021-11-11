# frozen_string_literal: true

def print_files(path)
  files = path ? Dir.entries(path).sort : Dir.entries('.').sort
  puts(files)
end

print_files(ARGV[0])
