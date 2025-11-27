use aztec::macros::aztec;
pub mod test;

#[aztec]
pub contract Counter {
    // aztec library imports
    use aztec::{
        macros::{functions::{external, initializer, internal, view}, storage::storage},
        protocol_types::address::AztecAddress,
    };

    // simple_log
    #[external("private")]
    fn simple_log() {
        let value = 1;
        Counter::at(context.this_address()).emit_public_log_internal(value).enqueue(&mut context);
    }

    // recursive_log
    #[external("private")]
    fn recursive_log(recursions: Field) {
        if recursions != 0 {
            Counter::at(context.this_address()).emit_public_log_internal(recursions).enqueue(
                &mut context,
            );
            Counter::at(context.this_address()).recursive_log(recursions - 1).call(&mut context);
        }
    }

    #[external("public")]
    #[internal]
    fn emit_public_log_internal(value: Field) {
        context.emit_public_log(value);
    }
}
