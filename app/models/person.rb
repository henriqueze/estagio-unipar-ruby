class Person < ApplicationRecord
	String kind:[:Fisica, :Juridica]

	has_many :sale
	has_many :purchase
	has_many :budget

	validates :person_cpf, :personC_cnpj, uniqueness:true
	validates :address_zip, :person_tel1, :name, presence: true

	validates_numericality_of :person_tel1, :person_tel2, length: { in: 8..11 },
		too_long: 'Deve ter no Maximo 10 numeros', too_short: 'Deve ter no minimo 8 Numeros'
	validates :person_email, uniqueness: true, :allow_blank => true
	validates_format_of :person_email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :allow_blank => true

	validates_cpf_format_of :person_cpf, presence: true, if: :tipo_fisica?
	validates_cnpj_format_of :personC_cnpj, presence: true, if: :tipo_juridica?
	validates :address_zip, length: { in: 8..8 }#, :allow_blank => true
	validates_inclusion_of :kind, in: %w(Fisica Juridica), message: "Aceita somente Fisica ou Juridica"


	def tipo_fisica?
		kind == "Fisica"
	end

	def tipo_juridica?
		kind == "Juridica"
	end

end
