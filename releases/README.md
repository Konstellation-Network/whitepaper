# releases/

Versioned PDF releases of the whitepaper. **No release exists yet** — the
current source is a v1.0 *draft* (see `../CHANGELOG.md`).

Rules (ENGINEERING.md §6.7):

- One file per version: `vX.Y.pdf`, plus `vX.Y.pdf.sha256`.
- **Never edited in place.** Exchanges and investors cite specific versions,
  and tokenomics changes need an auditable history. A correction is a new
  version. CI refuses any pull request that modifies or deletes a file here.
- A release is cut with `make release VERSION=vX.Y` from the repo root, which
  copies the built PDF and writes its checksum, followed by a `CHANGELOG.md`
  entry and a git tag of the same name.
- Before v1.0 is released: every `\todo{}` placeholder in `src/` must be
  resolved by a recorded decision, and every passage marked `[legal review]`
  must have been reviewed.
