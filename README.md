`.pluck`
Used to query single or multiple columns from the underlying table of a model. It accepts a list of column names as an argument and returns an array of values of the specified columns with the corresponding datatype. This returns an array. Not an ARR.  
 
`.distinct`
Used to prevent duplicates
 
ActiveRecord::Relation
.limit
.offset
.or
.sort
.reverse
classifications
includes
 
asc
desc
 
`ActiveRecord Query Interface Rails Guide`  
The methods are chainable
 

Know:
ActiveRecord Associations 
Request Response Cycle
Implement a Feature
Make Changes/Adding Feature in an application via Multiple Layers (MVC, Routes, etc.)
 
Forms
Partials
Nested Resources
Scope Methods
Review Requirements
 
`Tricky Requirements:` 
user_submittable attributes on the join model
nested resources
scope methods (this lesson?)
 
`.limit` `.offset`
We use limit to specify the number of records to be retrieved, and use offset to specify the number of records to skip before starting to return the records.
Client.limit(5)  Returns the first 5 in the table
SELECT * FROM clients LIMIT 5
 
`This returns 31, 32, 33, 34, and 35`
Client.limit(5).offset(30)
SELECT * FROM clients LIMIT 5 OFFSET 30
 
This is used with pagination (how many per page)


`2.5 OR Conditions`
OR conditions between two relations can be built by calling or on the first relation, and passing the second one as an argument.

Client.where(locked: true).or(Client.where(orders_count: [1,3,5]))
SELECT * FROM clients WHERE (clients.locked = 1 OR clients.orders_count IN (1,3,5))


`Scope`
This is used to outline conditions that we want. 
Refers to what you have access to and where you have it
Scope Methods in a Model
refers to which model objects meet these conditions
















# Boat.first_five can't be an array it has to be something that still has a connection to AR   








collection<<(object, …)
Adds one or more objects to the collection by setting their foreign keys to the collection’s primary key. Note that this operation instantly fires update SQL without waiting for the save or update call on the parent object, unless the parent object is a new record. This will also run validations and callbacks of associated object(s). 


Storing foreign keys is how we establish associations?? 


Regarding Project
We need to create a has many through relationship (many to many)
Where the join model has a user submittable attribute on it
We need to be able to take user submittable data and put it in the join table 
 








# Optimal Queries using Active Record

## Learning Goals

* Use ActiveRecord's AREL library to build optimized queries

## Introduction

In programming, a good maxim is this:

> Use the best tool for the job

For example, you don't want to use JavaScript to build a computer for flying to
the Moon. JavaScript doesn't have very good decimal precision and, at distances
as far as the Moon, getting a number off in the hundred-thousandths place after
the decimal is the difference between landing on that celestial orb or taking a
long trip through nothing, forever.

Databases are AMAZING at linking and summarizing data. Ruby is a nice
general-purpose programming language. So when we need to get data from a
database, we want to ask the DATABASE to do as much of that work as possible.
That's what it's good at. That's what it likes to do. It has sacrificed some
capabilities in order to do other capabilities ***extremely well***.

If you use this code:

```ruby
doctors = Doctor.all
first_six_drs = doctors[0..5]
```

You will get six doctors by using _RUBY_ to "section off" six doctors using
Ruby's range method (`[]`). But under the covers we asked the database for
**all** the doctors and then took six of them. Wouldn't it make more sense to
ask the database to get us ***only*** six `Doctor`s in the first place? That's
what the following code does:

```ruby
Doctor.limit(6).to_a
```

Functions like `limit` are provided by the "AREL" engine that's built into
ActiveRecord. AREL stands for "A Relational Algebra." If that sounds like some
complex, awesome Mathematics and set theory stuff, it is! Fortunately, we don't
have to get advanced degrees in mathematics to benefit from this engine. AREL
lets us query the database, via ActiveRecord, in an object-oriented-looking way
that uses as much of the database's power as possible.

## Use ActiveRecord's AREL Library To Build Optimized Queries

In this lab, we've provided the solution (commented out) to the tests. You
should step through the tests and "fix" each method to make the test pass. 

As you uncomment, be sure to evaluate the implementation we've provided you.
Methods like `order`, `where`, `includes` are all part of the AREL engine. You
should look up these methods in the [AREL documentation][ad], and see how
they're working to filter the data retrieved from the database before the
result "gets to Ruby-land."

## Conclusion

While it's not necessary to memorize all the chainable methods AREL provides
ActiveRecord, it's best to know some of the common methods you saw in this
lab. If you are working in a Rails environment, AREL can make your queries
more efficient, which can literally speed up your applications 1000x!

## Resources

* [AREL Documentation][ad]
* [ThoughtBot](http://thoughtbot.com/) - [Using Arel to Compose SQL Queries](http://robots.thoughtbot.com/using-arel-to-compose-sql-queries)

[ad]: https://guides.rubyonrails.org/active_record_querying.html

