# coding: utf-8

class Livro < Midia
    attr_reader :categoria, :autor

    include FormatadorMoeda

    def initialize(titulo, autor, isbn="1", numero_de_paginas, valor, categoria)
        @titulo = titulo
        @autor = autor
        @isbn = isbn
        @numero_de_paginas = numero_de_paginas
        @valor = valor
        @categoria = categoria
        @desconto = 0.15
    end

    def to_s
        "Autor: #{@autor}, ISBN: #{@isbn}, Páginas: #{@numero_de_paginas}, Categoria: #{@categoria}"
    end
end