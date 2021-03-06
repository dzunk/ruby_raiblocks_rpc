# frozen_string_literal: true
class RaiblocksRpc::Accounts < RaiblocksRpc::Proxy
  attr_accessor :addresses

  def initialize(addresses)
    unless addresses.is_a?(Array)
      raise RaiblocksRpc::MissingArguments,
            'Missing argument: addresses (str[])'
    end

    self.addresses = addresses
  end

  def proxy_params
    { accounts: :addresses }
  end

  def proxy_methods
    {
      accounts_balances: nil,
      accounts_create: { required: %i[wallet count], optional: %i[work] },
      accounts_frontiers: nil,
      accounts_pending: { required: %i[count], optional: %i[threshold source] }
    }
  end

  # TODO implement ability to instantiate Account instances like
  # accounts = Accounts.new(['abc', 'def'])
  # accounts.first
  # => RaiblocksRpc::Account address='abc'
  # [], each (more iterators?)
end
