# coding: utf-8

class CD < Midia
    def initialize(titulo, valor, categoria)
        super()

        @titulo = titulo
        @valor = valor
        @categoria = categoria
    end

    def to_s
        %Q{ Título: #{@titulo}, Valor: #{@valor} }
    end
end