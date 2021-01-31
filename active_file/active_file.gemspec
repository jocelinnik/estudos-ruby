# frozen_string_literal: true

require_relative "lib/active_file/version"

Gem::Specification.new do |spec|
    spec.name        = "active_file"
    spec.version     = ActiveFile::VERSION
    spec.description = "Just a file system database"
    spec.summary     = "Just a file system database"
    spec.author      = "Linnik Maciel"
    spec.files       = Dir["{lib/**/*.rb, lib/tasks/*.rake, README.md, Rakefile, active_file.gemspec}"]
end
