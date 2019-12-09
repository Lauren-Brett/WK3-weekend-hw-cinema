require_relative('../db/sql_runner')
require_relative('customer')
require_relative('ticket')
require_relative('film')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'] if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

def save()
  sql = "INSERT INTO films
  (
    title,
    price
    ) VALUES (
      $1, $2
      ) RETURNING id;"
  values = [@title, @price]
  films = SqlRunner.run(sql, values)
  @id = films[0]['id']
end

def self.delete_all()
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
end

def self.map_items(data)
  result = data.map{ |film| Film.new(film)}
end


def self.all()
  sql = "SELECT * FROM films"
  films = SqlRunner.run(sql)
  # result = films.map{ |film| Film.new(film)}
  # return result
  return Film.map_items(films)
end

def update()
  sql = "UPDATE films SET
  (
    title,
    price
    ) = (
      $1, $2
      ) WHERE id = $3;"
  values = [@title, @price, @id]
  SqlRunner.run(sql, values)
end

#
def customers()
  sql = "SELECT customers.* FROM customers
  INNER JOIN tickets ON tickets.customer_id = customers.id
  WHERE tickets.film_id = $1;"
  values = [@id]
  results = SqlRunner.run(sql, values)
return Customer.map_items(results)
end


def customers_name()
  sql = "SELECT name FROM customers
  INNER JOIN tickets ON tickets.customer_id = customers.id
  WHERE tickets.film_id = $1;"
  values = [@id]
  results = SqlRunner.run(sql, values)
  return Customer.map_items(results)
end

def tickets()
  sql = "SELECT tickets.customer_id FROM tickets
  WHERE film_id = $1"
  values = [@id]
  tickets = SqlRunner.run(sql, values)
  return Ticket.map_items(tickets)
end

def self.price
  sql = "SELECT price FROM films;"
  price_film = SqlRunner.run(sql)
  return Film.map_items(price_film)
end

def count_customers
  count_customers = customers()
  return count_customers
end

end
