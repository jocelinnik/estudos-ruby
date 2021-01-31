# coding: utf-8

require "bundler/setup"
require "brnumeros"

module FormatadorMoeda
    module ClassMethods
        def formata_moeda(*variaveis_e_metodos)
            variaveis_e_metodos.each do |name|
                define_method("#{name}_formatado") do
                    valor = respond_to?(name) ? send(name) : instance_variable_get("@#{name}")

                    "R$ #{valor}"
                end

                define_method("#{name}_por_extenso") do
                    valor = respond_to?(name) ? send(name) : instance_variable_get("@#{name}")

                    valor.por_extenso_em_reais
                end
            end
        end
    end

    def self.included(base)
        base.extend(ClassMethods)
    end
end