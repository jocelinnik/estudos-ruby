# coding: utf-8

require "bundler/setup"
require "active_file"

class Revista

    include(ActiveFile)

    field(:titulo)
    field(:valor)
end