# coding: utf-8

require "fileutils"

namespace :db do
    desc("Limpa todos os arquivos da pasta db/**")
    task :clear do
        FileUtils.rm(Dir["db/**/*.yml"])
    end
end