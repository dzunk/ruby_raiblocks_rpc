# frozen_string_literal: true
class RaiblocksRpc::Account < RaiblocksRpc::Proxy
  attr_accessor :address

  def initialize(address)
    unless address
      raise RaiblocksRpc::MissingArguments,
            'Missing argument: address (str)'
    end

    self.address = address
  end

  def proxy_params
    { account: :address }
  end

  def proxy_methods
    {
      account_balance: nil,
      account_block_count: nil,
      account_info: nil,
      account_create: { required: %i[wallet] },
      account_history: { required: %i[count] },
      account_list: nil,
      account_move: { required: %i[wallet source accounts] },
      account_key: nil,
      account_remove: { required: %i[wallet] },
      account_representative: nil,
      account_representative_set: { required: %i[wallet representative] },
      account_weight: nil,
      delegators: nil,
      delegators_count: nil,
      frontiers: { required: %i[count] },
      frontier_count: nil,
      ledger: { required: %i[count] },
      validate_account_number: nil,
      pending: { required: %i[count], optional: %i[threshold exists] },
      payment_wait: { required: %i[amount timeout] },
      accounts_balances: { required: %i[accounts] },
      accounts_create: {
        required: %i[accounts wallet count], optional: %i[work]
      },
      accounts_frontiers: { required: %i[accounts] },
      accounts_pending: {
        required: %i[accounts count], optional: %i[threshold source]
      }
    }
  end
end
