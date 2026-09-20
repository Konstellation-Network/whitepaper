# Konstellation whitepaper — build the PDF from src/whitepaper.tex.
#
# Produces a document only (ENGINEERING.md §5: `konstellation` is the only repo
# that produces an executable). Uses latexmk if present, otherwise tectonic.
# Output lands in build/; releases/ is written only by a deliberate `make release`.

SRC_DIR   := src
MAIN      := whitepaper
BUILD_DIR := build
PDF       := $(BUILD_DIR)/$(MAIN).pdf
SOURCES   := $(SRC_DIR)/$(MAIN).tex $(wildcard $(SRC_DIR)/sections/*.tex)

LATEXMK   := $(shell command -v latexmk 2>/dev/null)
TECTONIC  := $(shell command -v tectonic 2>/dev/null)

.PHONY: all pdf check clean release

all: pdf

pdf: $(PDF)

$(PDF): $(SOURCES)
	@mkdir -p $(BUILD_DIR)
ifneq ($(LATEXMK),)
	cd $(SRC_DIR) && latexmk -pdf -interaction=nonstopmode -halt-on-error \
	    -outdir=../$(BUILD_DIR) $(MAIN).tex
else ifneq ($(TECTONIC),)
	tectonic --keep-intermediates --outdir $(BUILD_DIR) $(SRC_DIR)/$(MAIN).tex
	# tectonic runs the TOC/todo-list passes itself; a second run settles page refs
	tectonic --keep-intermediates --outdir $(BUILD_DIR) $(SRC_DIR)/$(MAIN).tex
else
	@echo "no TeX engine found: install latexmk (TeX Live / MacTeX) or tectonic" >&2; exit 1
endif
	@echo "built $(PDF)"

# Structural checks that need no TeX: every \input resolves, every \label that
# is \ref'd exists, braces balance per file. Run in CI before the real build.
check:
	@scripts/check-structure.sh $(SRC_DIR)/$(MAIN).tex

# Copy the built PDF to releases/ under an explicit version. Never overwrite:
# a released version is immutable (ENGINEERING.md §6.7).
#   make release VERSION=v1.0
release: $(PDF)
	@test -n "$(VERSION)" || { echo "usage: make release VERSION=vX.Y" >&2; exit 1; }
	@test ! -e releases/$(VERSION).pdf || { echo "releases/$(VERSION).pdf already exists; releases are never edited in place" >&2; exit 1; }
	cp $(PDF) releases/$(VERSION).pdf
	cd releases && shasum -a 256 $(VERSION).pdf > $(VERSION).pdf.sha256
	@echo "released releases/$(VERSION).pdf — now add the CHANGELOG entry and tag $(VERSION)"

clean:
	rm -rf $(BUILD_DIR)
	cd $(SRC_DIR) && rm -f *.aux *.log *.out *.toc *.tod *.fls *.fdb_latexmk *.synctex.gz
