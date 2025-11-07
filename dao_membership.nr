# dao_membership.nr
use dep::std::hash::pedersen;

// Proves: user has sufficient DAO / reputation score to access gated features
pub fn verify_dao_membership(
    dao_passport_score: Field,
    min_dao_passport_score: Field
) -> Field {
    assert(
        dao_passport_score >= min_dao_passport_score,
        "DAO membership / reputation check failed"
    );
    let commitment = pedersen([dao_passport_score, min_dao_passport_score]);
    commitment
}
