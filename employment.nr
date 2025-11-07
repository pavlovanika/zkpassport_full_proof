# employment.nr
use dep::std::hash::pedersen;

// Proves: job_role_code matches required_job_role_code
pub fn verify_employment(job_role_code: Field, required_job_role_code: Field) -> Field {
    assert(job_role_code == required_job_role_code, "Employment check failed");
    let commitment = pedersen([job_role_code, required_job_role_code]);
    commitment
}
