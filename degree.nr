# degree.nr
use dep::std::hash::pedersen;

// Proves: user degree level meets or exceeds required threshold
pub fn verify_degree(degree_code: Field, required_degree_code: Field) -> Field {
    assert(degree_code >= required_degree_code, "Degree requirement not satisfied");
    let commitment = pedersen([degree_code, required_degree_code]);
    commitment
}
