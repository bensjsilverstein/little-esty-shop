require 'rails_helper'

RSpec.describe 'admin merchant index page' do
  describe '#index' do
    it 'displays the names of all the merchants' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Jon Doe Dough')
      merchant_3 = Merchant.create!(name: 'Mary Shelley Books')

      visit '/admin/merchants'

      within "#merchants-#{merchant_1.id}" do
      expect(page).to have_content('Spongebob The Merchant')
      expect(page).to_not have_content('Jon Doe Dough')
      end

      within "#merchants-#{merchant_2.id}" do
        expect(page).to have_content('Jon Doe Dough')
        expect(page).to_not have_content('Mary Shelley Books')
      end

      within "#merchants-#{merchant_3.id}" do
      expect(page).to have_content('Mary Shelley Books')
      expect(page).to_not have_content('Spongebob The Merchant')
      end
    end

    it 'each merchants name is a link that directs to that merchants admin show page'  do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Jon Doe Dough')
      merchant_3 = Merchant.create!(name: 'Mary Shelley Books')

      visit '/admin/merchants'

      within "#merchants-#{merchant_1.id}" do
        click_link('Spongebob The Merchant')

        expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
      end

      visit '/admin/merchants'

      within "#merchants-#{merchant_2.id}" do
        click_link('Jon Doe Dough')
        expect(current_path).to eq("/admin/merchants/#{merchant_2.id}")
      end
    end

    it 'shows the top 5 merchants by revenue' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      merchant_3 = Merchant.create!(name: 'Patrick The Starfish')
      merchant_4 = Merchant.create!(name: 'Mr. Krabs The Boss')
      merchant_5 = Merchant.create!(name: 'Barnacle Boy The Sidekick')
      merchant_6 = Merchant.create!(name: 'Mermaid Man The Hero')

      customer_1 = Customer.create!(first_name: 'Somany', last_name: 'Damntests')
      customer_2 = Customer.create!(first_name: 'Keeling', last_name: 'Mesoftly')
      customer_3 = Customer.create!(first_name: 'Withis', last_name: 'Words')

      item_1 = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
      item_3 = Item.create!(name: 'Knife', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_1.id)
      item_4 = Item.create!(name: 'Computer', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_1.id)
      item_5 = Item.create!(name: 'Table', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_1.id)
      item_5 = Item.create!(name: 'Bag of Money', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_1.id)
      item_6 = Item.create!(name: 'Decorative Wood 7', description: 'It is a piece of wood shaped like a 7', unit_price: 400, merchant_id: merchant_1.id)
      item_7 = Item.create!(name: 'Bag of Jacks', description: 'It is for playing Jacks', unit_price: 3, merchant_id: merchant_2.id)
      item_8 = Item.create!(name: 'Spatula2', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_2.id)
      item_9 = Item.create!(name: 'Spoon2', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_3.id)
      item_10 = Item.create!(name: 'Knife2', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_4.id)
      item_11 = Item.create!(name: 'Computer2', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_5.id)
      item_12 = Item.create!(name: 'Table2', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_6.id)
      item_13 = Item.create!(name: 'Bag of Money2', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_6.id)
      item_14 = Item.create!(name: 'Decorative Wood 72', description: 'It is a piece of wood shaped like a 7', unit_price: 400, merchant_id: merchant_6.id)

      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 1)

      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '983475', credit_card_expiration_date: nil, result: 'success')
      transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: '345', credit_card_expiration_date: nil, result: 'success')
      transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: '34657865', credit_card_expiration_date: nil, result: 'success')
      transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: '3456546', credit_card_expiration_date: nil, result: 'success')
      transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: '234234', credit_card_expiration_date: nil, result: 'success')
      transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: '6578', credit_card_expiration_date: nil, result: 'success')
      transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: '9789', credit_card_expiration_date: nil, result: 'success')
      transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: '3456', credit_card_expiration_date: nil, result: 'failed')

      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 2, status: 2)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 1, status: 2)
      invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_2.id, quantity: 4, unit_price: 2, status: 2)
      invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_7 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_3.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_8 = InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_9 = InvoiceItem.create!(item_id: item_8.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_10 = InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 4, status: 2)
      invoice_item_11 = InvoiceItem.create!(item_id: item_10.id, invoice_id: invoice_6.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_12 = InvoiceItem.create!(item_id: item_11.id, invoice_id: invoice_7.id, quantity: 2, unit_price: 3, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: item_12.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: item_13.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: item_14.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)

      visit "/admin/merchants"

      within "#top-five-merchants" do
        # expect('Spongebob The Merchant').to appear_before('Patrick The Starfish')
        # expect('Patrick The Starfish').to appear_before('Sandy The Squirrel Merchant')
        # expect('Sandy The Squirrel Merchant').to appear_before('Barnacle Boy The Sidekick')
        # expect('Barnacle Boy The Sidekick').to appear_before('Mr. Krabs The Boss')
        expect(page).to have_content('Mr. Krabs The Boss')
        expect(page).to_not have_content('Mermaid Man The Hero')
      end
    end

    it 'the top 5 merchants have a link to each merchant show page' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      merchant_3 = Merchant.create!(name: 'Patrick The Starfish')
      merchant_4 = Merchant.create!(name: 'Mr. Krabs The Boss')
      merchant_5 = Merchant.create!(name: 'Barnacle Boy The Sidekick')
      merchant_6 = Merchant.create!(name: 'Mermaid Man The Hero')

      customer_1 = Customer.create!(first_name: 'Somany', last_name: 'Damntests')
      customer_2 = Customer.create!(first_name: 'Keeling', last_name: 'Mesoftly')
      customer_3 = Customer.create!(first_name: 'Withis', last_name: 'Words')

      item_1 = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
      item_3 = Item.create!(name: 'Knife', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_1.id)
      item_4 = Item.create!(name: 'Computer', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_1.id)
      item_5 = Item.create!(name: 'Table', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_1.id)
      item_5 = Item.create!(name: 'Bag of Money', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_1.id)
      item_6 = Item.create!(name: 'Decorative Wood 7', description: 'It is a piece of wood shaped like a 7', unit_price: 400, merchant_id: merchant_1.id)
      item_7 = Item.create!(name: 'Bag of Jacks', description: 'It is for playing Jacks', unit_price: 3, merchant_id: merchant_2.id)
      item_8 = Item.create!(name: 'Spatula2', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_2.id)
      item_9 = Item.create!(name: 'Spoon2', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_3.id)
      item_10 = Item.create!(name: 'Knife2', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_4.id)
      item_11 = Item.create!(name: 'Computer2', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_5.id)
      item_12 = Item.create!(name: 'Table2', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_6.id)
      item_13 = Item.create!(name: 'Bag of Money2', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_6.id)
      item_14 = Item.create!(name: 'Decorative Wood 72', description: 'It is a piece of wood shaped like a 7', unit_price: 400, merchant_id: merchant_6.id)

      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 1)

      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '983475', credit_card_expiration_date: nil, result: 'success')
      transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: '345', credit_card_expiration_date: nil, result: 'success')
      transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: '34657865', credit_card_expiration_date: nil, result: 'success')
      transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: '3456546', credit_card_expiration_date: nil, result: 'success')
      transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: '234234', credit_card_expiration_date: nil, result: 'success')
      transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: '6578', credit_card_expiration_date: nil, result: 'success')
      transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: '9789', credit_card_expiration_date: nil, result: 'success')
      transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: '3456', credit_card_expiration_date: nil, result: 'failed')

      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 2, status: 2)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 1, status: 2)
      invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_2.id, quantity: 4, unit_price: 2, status: 2)
      invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_7 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_3.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_8 = InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_9 = InvoiceItem.create!(item_id: item_8.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_10 = InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 4, status: 2)
      invoice_item_11 = InvoiceItem.create!(item_id: item_10.id, invoice_id: invoice_6.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_12 = InvoiceItem.create!(item_id: item_11.id, invoice_id: invoice_7.id, quantity: 2, unit_price: 3, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: item_12.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: item_13.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: item_14.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)


      visit '/admin/merchants'

      within "#top-five-merchants" do
        expect(page).to have_link('Spongebob The Merchant')
        expect(page).to have_link('Patrick The Starfish')
        expect(page).to have_link('Sandy The Squirrel Merchant')
        expect(page).to have_link('Barnacle Boy The Sidekick')
        expect(page).to have_link('Mr. Krabs The Boss')
      end
    end

    it 'the top 5 merchants link will take you to the merchant show page' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      merchant_3 = Merchant.create!(name: 'Patrick The Starfish')
      merchant_4 = Merchant.create!(name: 'Mr. Krabs The Boss')
      merchant_5 = Merchant.create!(name: 'Barnacle Boy The Sidekick')
      merchant_6 = Merchant.create!(name: 'Mermaid Man The Hero')

      customer_1 = Customer.create!(first_name: 'Somany', last_name: 'Damntests')
      customer_2 = Customer.create!(first_name: 'Keeling', last_name: 'Mesoftly')
      customer_3 = Customer.create!(first_name: 'Withis', last_name: 'Words')

      item_1 = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
      item_3 = Item.create!(name: 'Knife', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_1.id)
      item_4 = Item.create!(name: 'Computer', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_1.id)
      item_5 = Item.create!(name: 'Table', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_1.id)
      item_5 = Item.create!(name: 'Bag of Money', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_1.id)
      item_6 = Item.create!(name: 'Decorative Wood 7', description: 'It is a piece of wood shaped like a 7', unit_price: 400, merchant_id: merchant_1.id)
      item_7 = Item.create!(name: 'Bag of Jacks', description: 'It is for playing Jacks', unit_price: 3, merchant_id: merchant_2.id)
      item_8 = Item.create!(name: 'Spatula2', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_2.id)
      item_9 = Item.create!(name: 'Spoon2', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_3.id)
      item_10 = Item.create!(name: 'Knife2', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_4.id)
      item_11 = Item.create!(name: 'Computer2', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_5.id)
      item_12 = Item.create!(name: 'Table2', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_6.id)
      item_13 = Item.create!(name: 'Bag of Money2', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_6.id)
      item_14 = Item.create!(name: 'Decorative Wood 72', description: 'It is a piece of wood shaped like a 7', unit_price: 400, merchant_id: merchant_6.id)

      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 1)

      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '983475', credit_card_expiration_date: nil, result: 'success')
      transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: '345', credit_card_expiration_date: nil, result: 'success')
      transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: '34657865', credit_card_expiration_date: nil, result: 'success')
      transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: '3456546', credit_card_expiration_date: nil, result: 'success')
      transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: '234234', credit_card_expiration_date: nil, result: 'success')
      transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: '6578', credit_card_expiration_date: nil, result: 'success')
      transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: '9789', credit_card_expiration_date: nil, result: 'success')
      transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: '3456', credit_card_expiration_date: nil, result: 'failed')

      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 2, status: 2)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 1, status: 2)
      invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_2.id, quantity: 4, unit_price: 2, status: 2)
      invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_7 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_3.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_8 = InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_9 = InvoiceItem.create!(item_id: item_8.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_10 = InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 4, status: 2)
      invoice_item_11 = InvoiceItem.create!(item_id: item_10.id, invoice_id: invoice_6.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_12 = InvoiceItem.create!(item_id: item_11.id, invoice_id: invoice_7.id, quantity: 2, unit_price: 3, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: item_12.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: item_13.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: item_14.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)

      visit '/admin/merchants'

      within "#top-five-merchants" do
        click_on 'Spongebob The Merchant'

        expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
      end
    end

    it 'shows the revenue for each of the top 5 merchants' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      merchant_3 = Merchant.create!(name: 'Patrick The Starfish')
      merchant_4 = Merchant.create!(name: 'Mr. Krabs The Boss')
      merchant_5 = Merchant.create!(name: 'Barnacle Boy The Sidekick')
      merchant_6 = Merchant.create!(name: 'Mermaid Man The Hero')

      customer_1 = Customer.create!(first_name: 'Somany', last_name: 'Damntests')
      customer_2 = Customer.create!(first_name: 'Keeling', last_name: 'Mesoftly')
      customer_3 = Customer.create!(first_name: 'Withis', last_name: 'Words')

      item_1 = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
      item_3 = Item.create!(name: 'Knife', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_1.id)
      item_4 = Item.create!(name: 'Computer', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_1.id)
      item_5 = Item.create!(name: 'Table', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_1.id)
      item_5 = Item.create!(name: 'Bag of Money', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_1.id)
      item_6 = Item.create!(name: 'Decorative Wood 7', description: 'It is a piece of wood shaped like a 7', unit_price: 400, merchant_id: merchant_1.id)
      item_7 = Item.create!(name: 'Bag of Jacks', description: 'It is for playing Jacks', unit_price: 3, merchant_id: merchant_2.id)
      item_8 = Item.create!(name: 'Spatula2', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_2.id)
      item_9 = Item.create!(name: 'Spoon2', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_3.id)
      item_10 = Item.create!(name: 'Knife2', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_4.id)
      item_11 = Item.create!(name: 'Computer2', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_5.id)
      item_12 = Item.create!(name: 'Table2', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_6.id)
      item_13 = Item.create!(name: 'Bag of Money2', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_6.id)
      item_14 = Item.create!(name: 'Decorative Wood 72', description: 'It is a piece of wood shaped like a 7', unit_price: 400, merchant_id: merchant_6.id)

      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 1)

      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: '983475', credit_card_expiration_date: nil, result: 'success')
      transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: '345', credit_card_expiration_date: nil, result: 'success')
      transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: '34657865', credit_card_expiration_date: nil, result: 'success')
      transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: '3456546', credit_card_expiration_date: nil, result: 'success')
      transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: '234234', credit_card_expiration_date: nil, result: 'success')
      transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: '6578', credit_card_expiration_date: nil, result: 'success')
      transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: '9789', credit_card_expiration_date: nil, result: 'success')
      transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: '3456', credit_card_expiration_date: nil, result: 'failed')

      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 2, status: 2)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 1, status: 2)
      invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_2.id, quantity: 4, unit_price: 2, status: 2)
      invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_3.id, quantity: 3, unit_price: 3, status: 2)
      invoice_item_7 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_3.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_8 = InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_9 = InvoiceItem.create!(item_id: item_8.id, invoice_id: invoice_4.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_10 = InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_5.id, quantity: 3, unit_price: 4, status: 2)
      invoice_item_11 = InvoiceItem.create!(item_id: item_10.id, invoice_id: invoice_6.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_12 = InvoiceItem.create!(item_id: item_11.id, invoice_id: invoice_7.id, quantity: 2, unit_price: 3, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: item_12.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: item_13.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)
      invoice_item_13 = InvoiceItem.create!(item_id: item_14.id, invoice_id: invoice_8.id, quantity: 4, unit_price: 1, status: 2)

      visit "/admin/merchants"

      within "#top-five-merchants" do
        expect(page).to have_content('$0.42')
        expect(page).to have_content('$0.12')
        expect(page).to have_content('$0.08')
        expect(page).to have_content('$0.06')
        expect(page).to have_content('$0.04')
      end
    end

    it 'has button to create a new merchant' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      merchant_3 = Merchant.create!(name: 'Patrick The Starfish')

      visit '/admin/merchants'

      expect(page).to have_link('Create New Merchant')
    end

    it 'when create new merchant button is clicked it directs to page to create a new merchant' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      merchant_3 = Merchant.create!(name: 'Patrick The Starfish')

      visit '/admin/merchants'

      click_link('Create New Merchant')

      expect(current_path).to eq("/admin/merchants/new")
    end

    it 'shows a button to Enable / Disable merchants' do
      merchant_1 = Merchant.create!(name: "Bob The Burgerman")
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      merchant_3 = Merchant.create!(name: 'Patrick The Starfish')

      visit "/admin/merchants"

      within "#merchants-#{merchant_1.id}" do
        expect(page).to have_selector(:link_or_button, "Enable Bob The Burgerman")
        expect(page).to have_selector(:link_or_button, "Disable Bob The Burgerman")
        expect(page).to_not have_selector(:link_or_button, "Enable Sandy The Squirrel Merchant")
        expect(page).to_not have_selector(:link_or_button, "Disable Sandy The Squirrel Merchant")
      end

      within "#merchants-#{merchant_2.id}" do
        expect(page).to have_selector(:link_or_button, "Enable Sandy The Squirrel Merchant")
        expect(page).to have_selector(:link_or_button, "Disable Sandy The Squirrel Merchant")
        expect(page).to_not have_selector(:link_or_button, "Enable Patrick The Starfish")
        expect(page).to_not have_selector(:link_or_button, "Disable Patrick The Starfish")
      end

      within "#merchants-#{merchant_3.id}" do
        expect(page).to have_selector(:link_or_button, "Enable Patrick The Starfish")
        expect(page).to have_selector(:link_or_button, "Disable Patrick The Starfish")
        expect(page).to_not have_selector(:link_or_button, "Bob The Burgerman")
        expect(page).to_not have_selector(:link_or_button, "Bob The Burgerman")
      end
    end

    it 'changes the merchants Enabled / Disabled  status' do
      merchant_1 = Merchant.create!(name: "Bob The Burgerman")
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')

      visit "/admin/merchants"

      click_on "Disable Bob The Burgerman"

      within "#merchants-#{merchant_1.id}" do
        expect(page).to have_current_path("/admin/merchants")
        expect(page).to have_content("Status: Disabled")
        expect(page).to_not have_content("Status: Enabled")
      end

      click_on "Enable Sandy The Squirrel Merchant"

      within "#merchants-#{merchant_2.id}" do
        expect(page).to have_current_path("/admin/merchants")
        expect(page).to have_content("Status: Enabled")
        expect(page).to_not have_content("Status: Disabled")
      end
    end

    it 'groups by the merchants Enabled / Disabled  status' do
      merchant_1 = Merchant.create!(name: "Bob The Burgerman")
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      merchant_2 = Merchant.create!(name: 'Patrick The Star')
      merchant_2 = Merchant.create!(name: 'Squidward')

      visit "/admin/merchants"

      click_on "Enable Bob The Burgerman"
      click_on "Enable Sandy The Squirrel Merchant"
      click_on "Disable Patrick The Star"
      click_on "Disable Squidward"

      within "#enabled_merchants" do
        expect(page).to have_current_path("/admin/merchants")
        expect(page).to have_content("Bob The Burgerman")
        expect(page).to have_content("Sandy The Squirrel Merchant")
        expect(page).to_not have_content("Patrick The Star")
        expect(page).to_not have_content("Squidward")
      end

      within "#disabled_merchants" do
        expect(page).to have_current_path("/admin/merchants")
        expect(page).to have_content("Patrick The Star")
        expect(page).to have_content("Squidward")
        expect(page).to_not have_content("Bob The Burgerman")
        expect(page).to_not have_content("Sandy The Squirrel Merchant")
      end
    end

    it 'has a top selling date for each merchant' do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2 = Merchant.create!(name: "Spongebob The Merchant")

      item_1 = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
      item_3 = Item.create!(name: 'Knife', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_1.id)
      item_4 = Item.create!(name: 'Computer', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_1.id)
      item_5 = Item.create!(name: 'Table', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_1.id)
      item_6 = Item.create!(name: 'Bag of Money', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_1.id)

      item_7 = Item.create!(name: 'Seaweed', description: 'It is big ball of seaweed', unit_price: 450, merchant_id: merchant_2.id)
      item_8 = Item.create!(name: 'Boxing Gloves', description: 'It is for kara-tay', unit_price: 2000, merchant_id: merchant_2.id)
      item_9 = Item.create!(name: 'Jelly', description: 'It is yummy', unit_price: 300, merchant_id: merchant_2.id)

      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      customer_2 = Customer.create!(first_name: "Trill", last_name: "Pickles")

      invoice_1 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_2 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_3 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_10 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")

      invoice_4 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")
      invoice_5 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")
      invoice_11 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")

      invoice_6 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_12 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_13 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")

      invoice_7 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_14 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")
      invoice_15 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")

      invoice_8 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_16 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_17 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")

      invoice_9 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_18 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")
      invoice_19 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")

      invoice_20 = Invoice.create!(status: 2, customer_id: customer_2.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")
      invoice_21 = Invoice.create!(status: 2, customer_id: customer_2.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")
      invoice_22 = Invoice.create!(status: 2, customer_id: customer_2.id, created_at: "Sun, 31 Jul 2022 16:04:49 UTC +00:00")
      invoice_23 = Invoice.create!(status: 2, customer_id: customer_2.id, created_at: "Sun, 31 Jul 2022 16:04:49 UTC +00:00")
      invoice_24 = Invoice.create!(status: 2, customer_id: customer_2.id, created_at: "Sun, 31 Jul 2022 16:04:49 UTC +00:00")
      invoice_25 = Invoice.create!(status: 2, customer_id: customer_2.id, created_at: "Sun, 31 Jul 2022 16:04:49 UTC +00:00")


      transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: 234, credit_card_expiration_date: nil, result: 0)
      transaction_2 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: 3456, credit_card_expiration_date: nil, result: 0)
      transaction_3 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: 876, credit_card_expiration_date: nil, result: 0)
      transaction_4 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: 5678, credit_card_expiration_date: nil, result: 0)
      transaction_5 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: 2345, credit_card_expiration_date: nil, result: 0)
      transaction_6 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: 567, credit_card_expiration_date: nil, result: 0)
      transaction_7 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: 234444, credit_card_expiration_date: nil, result: 0)
      transaction_8 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: 23675744, credit_card_expiration_date: nil, result: 0)
      transaction_9 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: 67, credit_card_expiration_date: nil, result: 0)
      transaction_10 = Transaction.create!(invoice_id: invoice_9.id, credit_card_number: 233444, credit_card_expiration_date: nil, result: 0)
      transaction_11 = Transaction.create!(invoice_id: invoice_10.id, credit_card_number: 5324, credit_card_expiration_date: nil, result: 0)
      transaction_12 = Transaction.create!(invoice_id: invoice_11.id, credit_card_number: 242244, credit_card_expiration_date: nil, result: 0)
      transaction_13 = Transaction.create!(invoice_id: invoice_12.id, credit_card_number: 445, credit_card_expiration_date: nil, result: 0)
      transaction_14 = Transaction.create!(invoice_id: invoice_13.id, credit_card_number: 234234, credit_card_expiration_date: nil, result: 0)
      transaction_15 = Transaction.create!(invoice_id: invoice_14.id, credit_card_number: 657, credit_card_expiration_date: nil, result: 0)
      transaction_16 = Transaction.create!(invoice_id: invoice_15.id, credit_card_number: 6787890, credit_card_expiration_date: nil, result: 0)
      transaction_17 = Transaction.create!(invoice_id: invoice_16.id, credit_card_number: 345435, credit_card_expiration_date: nil, result: 0)
      transaction_18 = Transaction.create!(invoice_id: invoice_17.id, credit_card_number: 2342356, credit_card_expiration_date: nil, result: 0)
      transaction_19 = Transaction.create!(invoice_id: invoice_18.id, credit_card_number: 54364567, credit_card_expiration_date: nil, result: 0)
      transaction_20 = Transaction.create!(invoice_id: invoice_19.id, credit_card_number: 435345, credit_card_expiration_date: nil, result: 1)

      transaction_21 = Transaction.create!(invoice_id: invoice_20.id, credit_card_number: 4967577, credit_card_expiration_date: nil, result: 0)
      transaction_22 = Transaction.create!(invoice_id: invoice_21.id, credit_card_number: 4967577, credit_card_expiration_date: nil, result: 0)
      transaction_23 = Transaction.create!(invoice_id: invoice_22.id, credit_card_number: 4967577, credit_card_expiration_date: nil, result: 0)
      transaction_24 = Transaction.create!(invoice_id: invoice_23.id, credit_card_number: 4967577, credit_card_expiration_date: nil, result: 0)
      transaction_25 = Transaction.create!(invoice_id: invoice_24.id, credit_card_number: 4967577, credit_card_expiration_date: nil, result: 0)
      transaction_26 = Transaction.create!(invoice_id: invoice_25.id, credit_card_number: 4967577, credit_card_expiration_date: nil, result: 0)

      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 2, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_1.id, invoice_id: invoice_2.id)
      invoice_item_3 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_1.id, invoice_id: invoice_3.id)
      invoice_item_4 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_1.id, invoice_id: invoice_10.id)

      invoice_item_5 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_2.id, invoice_id: invoice_4.id)
      invoice_item_6 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_2.id, invoice_id: invoice_5.id)
      invoice_item_7 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_2.id, invoice_id: invoice_11.id)

      invoice_item_8 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_3.id, invoice_id: invoice_6.id)
      invoice_item_8 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_3.id, invoice_id: invoice_12.id)
      invoice_item_8 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_3.id, invoice_id: invoice_13.id)

      invoice_item_9 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_4.id, invoice_id: invoice_7.id)
      invoice_item_9 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_4.id, invoice_id: invoice_14.id)
      invoice_item_9 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_4.id, invoice_id: invoice_15.id)

      invoice_item_10 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_5.id, invoice_id: invoice_8.id)
      invoice_item_10 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_5.id, invoice_id: invoice_16.id)
      invoice_item_10 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_5.id, invoice_id: invoice_17.id)

      invoice_item_11 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_6.id, invoice_id: invoice_9.id)
      invoice_item_11 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_6.id, invoice_id: invoice_18.id)
      invoice_item_11 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_6.id, invoice_id: invoice_19.id)

      invoice_item_12 = InvoiceItem.create!(quantity: 3, unit_price: 450, status: 2, item_id: item_7.id, invoice_id: invoice_20.id)
      invoice_item_12 = InvoiceItem.create!(quantity: 3, unit_price: 450, status: 2, item_id: item_7.id, invoice_id: invoice_21.id)

      invoice_item_13 = InvoiceItem.create!(quantity: 2, unit_price: 2000, status: 2, item_id: item_8.id, invoice_id: invoice_22.id)
      invoice_item_13 = InvoiceItem.create!(quantity: 2, unit_price: 2000, status: 2, item_id: item_8.id, invoice_id: invoice_23.id)

      invoice_item_14 = InvoiceItem.create!(quantity: 5, unit_price: 300, status: 2, item_id: item_9.id, invoice_id: invoice_24.id)
      invoice_item_14 = InvoiceItem.create!(quantity: 5, unit_price: 300, status: 2, item_id: item_9.id, invoice_id: invoice_25.id)

      visit "/admin/merchants"

      within "#top-five-#{merchant_1.id}" do
        expect(page).to have_content("Top Sale Date: 7/30/22")
      end

      within "#top-five-#{merchant_2.id}" do
        expect(page).to have_content("Top Sale Date: 7/31/22")
      end
    end
  end
end
