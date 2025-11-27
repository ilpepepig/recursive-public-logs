use crate::{Counter, test::utils};

#[test]
unconstrained fn simple_log_success() {
    let (env, contract_address, owner, _) = utils::setup_contract(false);

    env.call_private(owner, Counter::at(contract_address).simple_log());
}

#[test]
unconstrained fn recursive_log_success() {
    let (env, contract_address, owner, _) = utils::setup_contract(false);

    env.call_private(owner, Counter::at(contract_address).recursive_log(4));
}
