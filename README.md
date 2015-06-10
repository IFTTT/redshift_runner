# RedshiftRunner

RedshiftRunner is your one-stop shop for connecting to one or more Redshift instances, executing queries, and returning result sets with useful metadata.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redshift_runner'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redshift_runner

## Usage


### Initializing 

Add a file `config/initializers/redshift.rb` establishing a connection for each Redhsift instance or user (e.g. connect to 2 different Redshift clusters, or connect 2 different users to a single cluster).

Each connection takes the form:

```ruby
  RedshiftRunner::Connection.establish(
    connection_name,
    redshift_host,
    redshift_port,
    redshift_username,
    redshift_password,
    redshift_database_name,
  )
```

Recommendations:
 * Use environment secrets to store the connection information
 * Use the connection name "default" for your default Redshift connection

### Querying

Query your cluster with the simple command:

```ruby
  RedshiftRunner.exec_query my_sql_query_string
```

Results will be returned as a `RedshiftRunner::Result` object, which responds to the following methods: 

 * query_started_at: timestamp of query execution start
 * query_ended_at: timestamp of query execution end
 * query_duration_seconds: floating point query duration
 * status: status of query
 * message: longer description of query status
 * rows_affected: count of rows affected (for `insert` queries)
 * results: query result set represented as array containing one hash per row of results
 * query: sql query string executed


Example usage:

```ruby
  sql = <<-END_SQL
    select date(created_at) as registration_date, count(*) as new_user_count
    from users
    where created_at >= '2015-05-01'
    and created_at < '2015-06-01'
    group by date(created_at)
    order by date(created_at)
  END_SQL

  query_result = RedshiftRunner.exec_query(sql)
  
  query_result.results.each do |row|
    # do something with each row
  end
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/redshift_runner/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
