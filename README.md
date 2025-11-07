# README.md
zkpassport_multiproof_noir

Overview
This repository implements a flat, multi-file zkPassport-style identity proof system in Noir. All files are stored at a single level (no subfolders) while modeling a complex dApp structure with multiple circuits and commitments. The project demonstrates how a user can generate a composite zero-knowledge passport that proves several attributes simultaneously without revealing raw data:
- Age is above a required threshold.
- Nationality belongs to an allowed region.
- Employment role matches required criteria.
- Degree level satisfies a minimum requirement.
- Income exceeds a configured threshold.
- Residency is within an allowed region.

The system aggregates all per-attribute proofs into one zkPassport commitment, suitable as a building block for zkKYC, zkID, compliance-gated dApps, Aztec-style private access control, and zkPassport frameworks.

Files
- Nargo.toml — Noir package configuration and std dependency.
- main.nr — entrypoint; orchestrates all checks and prints the composite zkPassport commitment.
- age.nr — circuit for age threshold verification.
- nationality.nr — circuit for nationality and region verification.
- employment.nr — circuit for employment role verification.
- degree.nr — circuit for academic degree verification.
- income.nr — circuit for income threshold verification.
- residency.nr — circuit for residency-region verification.
- aggregator.nr — aggregates individual commitments into a single zkPassport commitment.
- inputs.json — example inputs for running and testing the circuits.
- age_proof_template.json — template for age proof metadata.
- nationality_proof_template.json — template for nationality proof metadata.
- employment_proof_template.json — template for employment proof metadata.
- degree_proof_template.json — template for degree proof metadata.
- income_proof_template.json — template for income proof metadata.
- residency_proof_template.json — template for residency proof metadata.

Installation
1. Install Noir (version 0.26.0 or compatible).
   Use the official Noir installer from the Noir documentation.
2. Clone or create the repository:
   - Create a new directory named zkpassport_multiproof_noir.
   - Place all files from this README structure into that directory at the same level (no folders).
3. Ensure Nargo.toml matches the provided configuration and that the std dependency is available.

Usage
1. Verify that all .nr files and json templates are in the same directory.
2. Run the main circuit with Nargo:
   - Set zkpassport_multiproof_noir as the working directory.
   - Execute the Noir command to run the default main.nr circuit.
3. The program will:
   - Execute all attribute verification circuits.
   - Enforce constraints via assertions.
   - Produce individual commitments for age, nationality, employment, degree, income, and residency.
   - Compute a final aggregated zkPassport commitment.

Expected Output
On successful execution you should see console output similar to:
- Header indicating zkPassport Multi-Attribute Proof.
- Printed commitments for each attribute:
  - Age commitment
  - Nationality commitment
  - Employment commitment
  - Degree commitment
  - Income commitment
  - Residency commitment
- A final aggregated zkPassport commitment derived from all sub-commitments.
- A confirmation line indicating that all constraints are satisfied and the composite proof is valid.

If any condition fails (for example user_age < min_age or income_value < min_income_required), the corresponding assert message will be triggered and the proof will be considered invalid.

Notes
- This project is a conceptual template. All numeric codes (for countries, regions, roles, degrees) are placeholders and should be replaced with real encodings or commitments in production.
- In a real zkPassport system:
  - Raw user attributes would be verified off-chain by trusted issuers.
  - Only commitments or Merkle-inclusion proofs would be used inside the circuits.
  - The final aggregated commitment would be verified on-chain by a smart contract (e.g. in Aztec or other zk-rollup ecosystems).
- The design intentionally keeps all files at one level to simplify integration into repositories where nested folders are undesirable, while still simulating a 10–50 file zk identity project.
- You can extend this layout by:
  - Adding more *.nr circuits for extra attributes (PEP checks, sanctions lists, DAO membership, reputation).
  - Adding additional *_proof_template.json files to describe how each circuit’s proof would be serialized.
  - Integrating verifiers or bindings in another language (TypeScript, Rust, etc.) in the same flat directory.
