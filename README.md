# RaiblocksRpc

An RPC wrapper for RaiBlocks written in Ruby.  It provides a client you can call explicitly as well as proxy objects that make working with a Raiblocks node easier.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'raiblocks_rpc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install raiblocks_rpc

## Usage

There are two ways to use this gem.  You can make direct calls to the RPC client or use the provided proxy objects.

In either case, the client should first be configured to connect to a RaiBlocks node.  If you do not specify host or port before using the client, then `localhost:7076` will be used by default.

```ruby
  RaiblocksRpc::Client.host = 'localhost'
  RaiblocksRpc::Client.port = 7076
````

### Raw RPC Calls

You can use the RPC client to make raw RPC calls to a RaiBlocks node according to the documentation at [RaiBlocks RPC Docs](https://github.com/clemahieu/raiblocks/wiki/RPC-protocol).

Every call requires an `action`, which is passed as the first argument to `call`.  Depending on the action, there may be additional required or optional parameters that are passed as an options hash.

```ruby
  RaiblocksRpc::Client.instance.call(:account_balance, account: 'xrb_someaddress1234')
  # => {"balance"=>0, "pending"=>0}
````

Response data are provided as `Hashie` objects with integer coercion, indifferent access, and method access included.  Therefore you have several options for accessing values.

```ruby
  data = RaiblocksRpc::Client.instance.call(:account_balance, account: 'xrb_someaddress1234')
  # => {"balance"=>0, "pending"=>0}
  data.balance
  # => 0
  data[:balance]
  # => 0
  data['balance']
  # => 0
````

### Proxy Objects

A few proxy objects are provided as a means to logically group RPC calls. Here we do not strictly follow the grouping as expressed on the [RaiBlocks RPC Docs](https://github.com/clemahieu/raiblocks/wiki/RPC-protocol).  Instead, the following objects are provided:

```ruby
  RaiblocksRpc::Account # { account: 'xrb_address12345' }
  RaiblocksRpc::Accounts # { accounts: ['xrb_address12345', 'xrb_address67890] }
  RaiblocksRpc::Wallet # { wallet: 'F3093AB' }
  RaiblocksRpc::Network
  RaiblocksRpc::Node
  RaiblocksRpc::Util
```

`Account`, `Accounts`, and `Wallet` each require parameters to be passed during initialization.  You can then make calls on these objects without needing to pass in the params for subsequent calls.

Methods whose prefix matches the class name, such as in `account_`, also have an abbreviated version so instead of calling `account_balance`, you can call simply `balance`.


```ruby
  account = RaiblocksRpc::Account.new('xrb_someaddress1234')

  data = account.balance
  # => {"balance"=>0, "pending"=>0}
  data.balance
  # => 0
  data.pending
  # => 0

  data = account.weight
  # => {"weight"=>13552245528000000000000000000000000}
  data.weight
  # => 13552245528000000000000000000000000
```

Some methods appear on multiple objects for convenience.

```ruby
  RaiblocksRpc::Node.new.block_count
  # => {"count"=>314848, "unchecked"=>4793586}

  RaiblocksRpc::Network.new.block_count
  # => {"count"=>314848, "unchecked"=>4793642}
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
