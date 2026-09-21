# whitepaper

The Konstellation Network whitepaper: LaTeX source and versioned PDF releases.

Kept separate from `docs` because exchanges and investors cite specific
versions, and tokenomics changes need an auditable history
(`ENGINEERING.md §6.7`).

## Layout

```
whitepaper/
├── src/
│   ├── whitepaper.tex        # main file: preamble, title, \input of each section
│   └── sections/*.tex        # one file per section
├── releases/                 # vX.Y.pdf + .sha256; never edited in place (empty: no release yet)
├── scripts/check-structure.sh# TeX-free structural checks (inputs, refs, braces)
├── Makefile                  # make pdf | check | release VERSION=vX.Y | clean
├── CHANGELOG.md
└── CODEOWNERS
```

## Status

**v1.0 is a draft.** The chain is pre-testnet; nothing described is deployed.
The PDF ends with an auto-generated list of every `\todo{}` placeholder —
each is a fact or decision the source documents do not yet contain. Passages
marked `[legal review]` have not been reviewed by counsel. Neither kind of
marker may be resolved by guessing.

## Sources of truth

The whitepaper *describes* decisions; it does not make them.

- Every economic number comes from the org-root `TOKENOMICS.md`.
- Every design statement cites a decision in `ENGINEERING.md §11` (D1–D17).
- When either file changes a number the whitepaper carries, this repo gets a
  new version; the old PDF stays in `releases/`.

## Build

```sh
make          # → build/whitepaper.pdf (latexmk -pdf if installed, else tectonic)
make check    # structural checks only; needs no TeX
make clean
```

Any TeX Live / MacTeX with `latexmk`, or [tectonic](https://tectonic-typesetting.github.io/),
will do. CI (`.github/workflows/build.yml`) builds the PDF on every pull request
with `latexmk -pdf -halt-on-error`, fails on unresolved references, uploads the
PDF as a workflow artifact, and refuses any PR that modifies a file already in
`releases/`.

## Releasing a version

1. Resolve every `\todo{}` and `[legal review]` marker for the scope of the release.
2. Bump `\wpversion` / `\wpdate` in `src/whitepaper.tex`.
3. `make release VERSION=vX.Y` — copies the PDF into `releases/` with a checksum
   and refuses to overwrite an existing version.
4. Move the `Unreleased` entry in `CHANGELOG.md` under the version heading.
5. Tag the commit `vX.Y`.
