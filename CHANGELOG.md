# Changelog

All notable changes to the whitepaper. Versions correspond to files in
`releases/`, which are never edited in place. Economic parameters change only
with a new version.

## Unreleased

### v1.0 (draft) — 2026-09-20

First complete draft. Source in `src/whitepaper.tex` + `src/sections/*.tex`.
Not released: no PDF in `releases/`. Every number is taken from
`TOKENOMICS.md`; every design statement cites a decision in
`ENGINEERING.md §11` (D1–D15). Contents:

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
- Validator set: ten independent operators at genesis, `max_validators` 30,
  admission permissioned via `MsgCreateValidator` disabled in circuit-breaker
  genesis state (D7 as re-decided 2026-09-20, D16), identical on testnet-1
  and mainnet; a staged roadmap for opening the set with dates and triggers
  left as placeholders.
- Bridges and value ceiling: no bridge on day one (D8) and the four-step
  opening sequence; the safety rails — circuit breaker (D14), IBC rate limiting
  (D15), bridge caps, halt drill.
- Compliance (D6): allow/block lists, timelock, emergency freeze with
  auto-expiry, governance override, precompile at `0x…0900`; the §10 positioning
  and legal-obligation risks stated in full; marked for legal review.
- Account abstraction: ERC-4337 EntryPoints v0.7 / v0.8 and SenderCreators
  preinstalled at canonical addresses, p256 precompile, EIP-7702 handling
  including the compliance interaction.
- Security: audit-the-delta plan with Informal Systems (D9), bug bounty
  before mainnet, continuous assurance, the launch sequence (§15).
- Disclaimers (standard form, marked for legal review).
- Appendix: decision record D1–D16 with dates; glossary.
- Auto-generated list of every `\todo{}` placeholder at the end of the PDF.

Repo scaffolding in the same change: `Makefile` (latexmk or tectonic),
`scripts/check-structure.sh`, GitHub Actions build on PRs (actions pinned to
commit SHAs) with a guard that refuses in-place edits to `releases/`,
`CODEOWNERS`, `releases/README.md`.
