# coding: utf-8

require File.expand_path("lib/loja_virtual")

windows = DVD.new("Windows 7 for Dummies", 98.9, :sistemas_operacionais)
p(windows.valor_por_extenso)