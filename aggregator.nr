# aggregator.nr
use dep::std::hash::pedersen;

// Aggregates all attribute commitments into a single zkPassport commitment.
// This serves as a compact on-chain verifiable handle for the full identity proof.
pub fn aggregate_passport(
    age_commitment: Field,
    nationality_commitment: Field,
    employment_commitment: Field,
    degree_commitment: Field,
    income_commitment: Field,
    residency_commitment: Field,
    sanctions_commitment: Field,
    pep_commitment: Field,
    dao_membership_commitment: Field
) -> Field {
    let c1 = pedersen([age_commitment, nationality_commitment]);
    let c2 = pedersen([employment_commitment, degree_commitment]);
    let c3 = pedersen([income_commitment, residency_commitment]);
    let c4 = pedersen([sanctions_commitment, pep_commitment]);
    let c5 = pedersen([dao_membership_commitment, 999]); // 999 = aggregator salt

    let l1 = pedersen([c1, c2]);
    let l2 = pedersen([c3, c4]);
    let aggregated = pedersen([l1, l2]);
    let final_commitment = pedersen([aggregated, c5]);

    final_commitment
}
