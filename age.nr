# age.nr
use dep::std::hash::pedersen;

// Proves: user_age >= min_age
pub fn verify_age(user_age: Field, min_age: Field) -> Field {
    assert(user_age >= min_age, "Age requirement not met");
    let commitment = pedersen([user_age, min_age]);
    commitment
}
