# coding: utf-8

class Relatorio
  def initialize(biblioteca)
    @biblioteca = biblioteca
  end

  def total
    @biblioteca.midias.map(&:valor).inject(:+)
  end

  def titulos
    @biblioteca.midias.map &:titulo
  end
end