# Changelog

All notable changes to the whitepaper. Versions correspond to files in
`releases/`, which are never edited in place. Economic parameters change only
with a new version.

## Unreleased

### Three networks, four launch validators — 2026-09-29

D7 re-decided by the founder on 2026-09-29 (Solana-style network split):

- Validator set: **four** foundation-run validators at genesis on
  `konstellation-1` and `testnet-1` (was ten); `max_validators` stays 30
  (twenty-six seats empty at genesis); admission permissioned via D16,
  moving to permissionless by governance. Every "ten" in the validator,
  overview, architecture, compliance, security, tokenomics and appendix
  sections updated.
- New network `devnet-1` (EIP-155 56672) for application developers: one
  foundation validator, same release as mainnet, faucet-fed, rarely reset.
  Naming table and a new "Networks" subsection (§ overview) describe all
  three; `testnet-1` is described as the validator/operations rehearsal
  network where releases land first.
- Upgrade order stated: `testnet-1` → `devnet-1` (1–2 weeks before mainnet)
  → `konstellation-1` (security section).

### v1.0 (draft) — 2026-09-20

First complete draft. Source in `src/whitepaper.tex` + `src/sections/*.tex`.
Not released: no PDF in `releases/`. Every number is taken from
`TOKENOMICS.md`; every design statement cites a decision in
`ENGINEERING.md §11` (D1–D17). Contents:

- Overview: sovereign L1, Cosmos SDK + `cosmos/evm`; naming table
  (KASH, `esp`, 18 decimals, `kons`, chain IDs 5667 / 56671).
- Architecture: imported-vs-implemented posture, the never-fork policy and the
  August 2026 incident behind it, BlockSTM off at launch with the shadow-node
  enablement plan.
- Tokenomics: 1 B KASH genesis supply and allocation (322 M / 32.2 % liquid
  at genesis: team 10 % liquid, community-pool seed 50 M in genesis
  distribution state, 280 M in tranche wallets); D4 issuance
  `annual KASH = F × √(bonded KASH)`, F = 1265, with the APR table; D5
  base-fee burn and the net-supply dynamic; D10 staking and D11 governance
  parameters; D12 Solidity vesting (team 10 % liquid + 90 % cliff-and-linear,
  revocable; community tranches non-revocable).
- Validator set: ten foundation-run validators at genesis (centralised and
  permissioned, stated plainly; all governance power is the foundation's until
  outside stake is bonded; loss of either cloud provider halts block
  production), `max_validators` 30, admission of independent
  operators via `MsgCreateValidator` disabled in circuit-breaker genesis state
  (D7 as re-decided 2026-09-20, D16), identical on testnet-1 and mainnet; a staged roadmap for opening the set with dates and triggers
  left as placeholders.
- Bridges and value ceiling: no bridge on day one (D8) and the four-step
  opening sequence; the safety rails — circuit breaker (D14), IBC rate limiting
  (D15), bridge caps, halt drill.
- Compliance (D6): allow/block lists, timelock, emergency freeze with
  auto-expiry, governance override, precompile at `0x…0900`; the §10 positioning
  and legal-obligation risks stated in full; the current build's residuals
  stated honestly (a freeze does not immobilise balance — bank-level
  restriction planned; governance voters are freezable — fix planned);
  marked for legal review.
- Account abstraction: ERC-4337 EntryPoints v0.7 / v0.8 and SenderCreators
  preinstalled at canonical addresses, p256 precompile, EIP-7702 handling
  including the compliance interaction; Prague fork at genesis, Osaka not
  enabled (D17).
- Security: audit-the-delta plan with Informal Systems (D9), bug bounty
  before mainnet, continuous assurance, the launch sequence (§15).
- Disclaimers (standard form, marked for legal review).
- Appendix: decision record D1–D17 with dates; glossary.
- Auto-generated list of every `\todo{}` placeholder at the end of the PDF.

Repo scaffolding in the same change: `Makefile` (latexmk or tectonic),
`scripts/check-structure.sh`, GitHub Actions build on PRs (actions pinned to
commit SHAs) with a guard that refuses in-place edits to `releases/`,
`CODEOWNERS`, `releases/README.md`.
