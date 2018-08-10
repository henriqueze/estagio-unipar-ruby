class Sale < ApplicationRecord
	belongs_to :person
	belongs_to :payment_type

	has_many :accounts_receivables
	has_many :item_sales, dependent: :destroy
	has_many :products, through: :item_sales

	validates :item_sales, :total_value, presence: true


	accepts_nested_attributes_for :item_sales, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :products, reject_if: :all_blank, allow_destroy: true

	def atualiza_estoque_diminui
		products.each do |product|
			item_sale = item_sales.find_by(product_id: product)
			product.stock -= item_sale.amount
			product.save
		end
	end

	def atualiza_estoque_aumenta
		products.each do |product|
			item_sale = item_sales.find_by(product_id: product)
			product.stock += item_sale.amount
			product.save
		end
	end

	private

	def valida_quantidade_produto
		if item_sales.empty?
			errors.add(:base, 'Pedido deve ter ao menos um item')
		end
	end

	end

