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

    // two_field_log
    #[external("private")]
    fn two_field_log() {
        let value = 1;
        Counter::at(context.this_address()).emit_two_field_public_log_internal(value, value + 1).enqueue(&mut context);
    }

    // three_field_log
    #[external("private")]
    fn three_field_log() {
        let value = 1;
        Counter::at(context.this_address())
            .emit_three_field_public_log_internal(value, value + 1, value + 2)
            .enqueue(&mut context);
    }

    // ten_field_log
    #[external("private")]
    fn ten_field_log() {
        let value = 1;
        Counter::at(context.this_address()).emit_ten_field_public_log_internal(
            value,
            value + 1,
            value + 2,
            value + 3,
            value + 4,
            value + 5,
            value + 6,
            value + 7,
            value + 8,
            value + 9,
        )
        .enqueue(&mut context);
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

    #[external("public")]
    #[internal]
    fn emit_two_field_public_log_internal(value_1: Field, value_2: Field) {
        context.emit_public_log([value_1, value_2]);
    }

    #[external("public")]
    #[internal]
    fn emit_three_field_public_log_internal(
        value_1: Field,
        value_2: Field,
        value_3: Field,
    ) {
        context.emit_public_log([value_1, value_2, value_3]);
    }

    #[external("public")]
    #[internal]
    fn emit_ten_field_public_log_internal(
        value_1: Field,
        value_2: Field,
        value_3: Field,
        value_4: Field,
        value_5: Field,
        value_6: Field,
        value_7: Field,
        value_8: Field,
        value_9: Field,
        value_10: Field,
    ) {
        context.emit_public_log([value_1, value_2, value_3, value_4, value_5, value_6, value_7, value_8, value_9, value_10]);
    }
}
