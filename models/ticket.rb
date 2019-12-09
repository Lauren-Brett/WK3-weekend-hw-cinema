require_relative('../db/sql_runner')
require_relative('customer')
require_relative('ticket')
require_relative('film')


class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

def initialize(options)
  @id = options['id'] if options['id']
  @customer_id = options['customer_id'].to_i
  @film_id = options['film_id'].to_i
end

def save()
  sql = "INSERT INTO tickets
  (
    customer_id,
    film_id
    ) VALUES (
      $1, $2
      ) RETURNING id;"
  values = [@customer_id, @film_id]
  tickets = SqlRunner.run(sql, values)
  @id = tickets[0]['id'].to_i
end

def self.delete_all()
  sql = "DELETE FROM tickets"
  SqlRunner.run(sql)
end


def self.map_items(data)
  result = data.map{ |ticket| Ticket.new(ticket)}
end


def self.all()
  sql = "SELECT * FROM tickets"
  tickets = SqlRunner.run(sql)
  return Ticket.map_items(tickets)
end

def update()
  sql = "UPDATE tickets SET
  (
    customer_id,
    film_id
    ) = (
      $1, $2
      ) WHERE id = $3;"
  values = [@customer_id, @film_id, @id]
  SqlRunner.run(sql, values)
end


def customers()
  sql = "SELECT customers.name FROM customers
  INNER JOIN tickets
  ON customers.id = tickets.customer_id;"
  # values = [@id]
  results = SqlRunner.run(sql)
  return Customer.map_items(results)
end

# def self.customers()
#   sql = "SELECT customers.name FROM customers
#   INNER JOIN tickets
#   ON customers.id = tickets.customer_id;"
#   # values = [@id]
#   results = SqlRunner.run(sql)
#   return Customer.map_items(results)
# end





end
