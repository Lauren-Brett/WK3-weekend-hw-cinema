require('pry')
require_relative('models/customer')
require_relative('models/ticket')
require_relative('models/film')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new({ 'name' => 'Chloe', 'funds' => 20})
customer1.save()

customer2 = Customer.new({ 'name' => 'Sophie', 'funds' => 30})
customer2.save()

customer3 = Customer.new({ 'name' => 'Mia', 'funds' => 10})
customer3.save()



film1 = Film.new({ 'title' => 'Drive', 'price' => 8})
film1.save()

film2 = Film.new({ 'title' => 'Place Beyond the Pines', 'price' => 8})
film2.save()

film3 = Film.new({ 'title' => 'Its A Wonderful Life', 'price' => 12})
film3.save()



ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id})
ticket2.save()

ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film3.id})
ticket3.save()

ticket4 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id})
ticket4.save()

ticket5 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket5.save()

ticket6 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film3.id})
ticket6.save()



binding.pry
nil
