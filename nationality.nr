
# nationality.nr
use dep::std::hash::pedersen;

// Proves: nationality is non-zero and region marker equals allowed_region_code
// In production, nationality_code would be derived from an issuer-signed claim or Merkle leaf.
pub fn verify_nationality(nationality_code: Field, allowed_region_code: Field) -> Field {
    assert(nationality_code != 0, "Invalid nationality code");
    // Example policy: allowed_region_code == 100 represents a specific compliant region set.
    assert(allowed_region_code == 100, "User not in allowed region");
    let commitment = pedersen([nationality_code, allowed_region_code]);
    commitment
}
