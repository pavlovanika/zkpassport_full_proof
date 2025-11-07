# income.nr
use dep::std::hash::pedersen;

// Proves: income_value >= min_income_required without revealing granular structure
pub fn verify_income(income_value: Field, min_income_required: Field) -> Field {
    assert(income_value >= min_income_required, "Income requirement not met");
    let commitment = pedersen([income_value, min_income_required]);
    commitment
}
