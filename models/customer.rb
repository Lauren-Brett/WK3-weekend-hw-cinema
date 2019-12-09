require_relative('../db/sql_runner')
require_relative('customer')
require_relative('ticket')
require_relative('film')


class Customer

attr_reader :id
attr_accessor :name, :funds

def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @funds = options['funds'].to_i
end

def save()
  sql = "INSERT INTO customers
  (
    name,
    funds
    ) VALUES (
      $1, $2
      ) RETURNING id;"
  values = [@name, @funds]
  customers = SqlRunner.run(sql, values)
  @id = customers[0]['id'].to_i
end

def self.delete_all()
  sql = "DELETE FROM customers"
  SqlRunner.run(sql)
end

def self.map_items(data)
  result = data.map{ |customer| Customer.new(customer)}
end

def self.all()
  sql = "SELECT * FROM customers"
  customers = SqlRunner.run(sql)
  return Customer.map_items(customers)
end

def update()
  sql = "UPDATE customers SET
  ( name,
    funds
    ) = (
      $1, $2
    ) WHERE id = $3;"
  values = [@name, @funds, @id]
  SqlRunner.run(sql, values)
end


def films()
  sql = "SELECT films.* FROM films
    INNER JOIN tickets ON tickets.film_id = films.id
    WHERE tickets.customer_id = $1;"
  values = [@id]
  results = SqlRunner.run(sql, values)
  return Film.map_items(results)
end


def tickets()
  sql = "SELECT * FROM tickets WHERE customer_id = $1;"
  values = [@id]
  results = SqlRunner.run(sql, values)
  return Ticket.map_items(results)
end

def count_films
  count_films = films()
  return count_films.count
end

def enough_funds(price)
  if @funds >= price
    return true
  end
end

def film_price()
  sql = "SELECT films.price FROM films
  INNER JOIN tickets ON tickets.film_id = films.id
  WHERE tickets.customer_id = $1;"
  values = [@id]
  result = SqlRunner.run(sql)

end

def decrease_funds(price)
  enough_funds(price)
  result = @funds - tickets()
  return result
  update
end

# def buy_ticket(film)
#
#
#   return @funds - price_of_ticket
#   return @funds - Films(film).price
# end



end
