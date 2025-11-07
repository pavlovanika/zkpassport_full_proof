# main.nr
mod age;
mod nationality;
mod employment;
mod degree;
mod income;
mod residency;
mod sanctions;
mod pep_check;
mod dao_membership;
mod aggregator;

use age::verify_age;
use nationality::verify_nationality;
use employment::verify_employment;
use degree::verify_degree;
use income::verify_income;
use residency::verify_residency;
use sanctions::verify_sanctions_clearance;
use pep_check::verify_pep_status;
use dao_membership::verify_dao_membership;
use aggregator::aggregate_passport;

fn main() {
    // Example inputs (in real systems they are derived from commitments, Merkle proofs, or issuer signatures)
    let user_age: Field = 23;
    let min_age: Field = 18;

    let nationality_code: Field = 764;          // TH (example)
    let allowed_region_code: Field = 100;       // Region marker, e.g. "Asia"

    let job_role_code: Field = 101;             // Software/Protocol Engineer
    let required_job_role_code: Field = 101;

    let degree_code: Field = 501;               // Bachelor+ level
    let required_degree_code: Field = 400;      // Minimum education threshold

    let income_value: Field = 80000;
    let min_income_required: Field = 50000;

    let residency_country_code: Field = 764;    // TH
    let allowed_residency_region_code: Field = 100;

    let sanctions_flag_code: Field = 0;         // 0 = not sanctioned; 1 = sanctioned
    let pep_flag_code: Field = 0;               // 0 = non-PEP; 1 = PEP (simplified)

    let dao_passport_score: Field = 42;         // Example on-chain reputation / DAO membership score
    let min_dao_passport_score: Field = 10;

    // Individual zkPassport-style checks (each returns a Field commitment)
    let age_commitment = verify_age(user_age, min_age);
    let nationality_commitment = verify_nationality(nationality_code, allowed_region_code);
    let employment_commitment = verify_employment(job_role_code, required_job_role_code);
    let degree_commitment = verify_degree(degree_code, required_degree_code);
    let income_commitment = verify_income(income_value, min_income_required);
    let residency_commitment = verify_residency(residency_country_code, allowed_residency_region_code);
    let sanctions_commitment = verify_sanctions_clearance(sanctions_flag_code);
    let pep_commitment = verify_pep_status(pep_flag_code);
    let dao_membership_commitment =
        verify_dao_membership(dao_passport_score, min_dao_passport_score);

    // Aggregate all commitments into a single zkPassport commitment
    let passport_commitment =
        aggregate_passport(
            age_commitment,
            nationality_commitment,
            employment_commitment,
            degree_commitment,
            income_commitment,
            residency_commitment,
            sanctions_commitment,
            pep_commitment,
            dao_membership_commitment
        );

    // Publicly visible outputs: no raw personal data, only commitments and a final proof handle
    std::println("🪪 zkPassport Multi-Attribute Proof (Noir)");
    std::println("Age commitment: {}", age_commitment);
    std::println("Nationality commitment: {}", nationality_commitment);
    std::println("Employment commitment: {}", employment_commitment);
    std::println("Degree commitment: {}", degree_commitment);
    std::println("Income commitment: {}", income_commitment);
    std::println("Residency commitment: {}", residency_commitment);
    std::println("Sanctions commitment: {}", sanctions_commitment);
    std::println("PEP commitment: {}", pep_commitment);
    std::println("DAO membership commitment: {}", dao_membership_commitment);
    std::println("🔐 Aggregated zkPassport commitment: {}", passport_commitment);
    std::println("✅ All constraints satisfied. Composite zkPassport proof is valid.");
}
