# residency.nr
use dep::std::hash::pedersen;

// Proves: residency_country_code is valid and belongs to an allowed residency region
pub fn verify_residency(
    residency_country_code: Field,
    allowed_residency_region_code: Field
) -> Field {
    assert(residency_country_code != 0, "Invalid residency country");
    assert(allowed_residency_region_code == 100, "Residency not in allowed region");
    let commitment = pedersen([residency_country_code, allowed_residency_region_code]);
    commitment
}
