VERSION=$(shell ./setup.py --version)
AUTHOR=$(shell ./setup.py --author)
AUTHOR_EMAIL=$(shell ./setup.py --author-email)

all install:
	@echo This Makefile does not build and install the project.
	@echo Use setup.py script
	@exit -1

changelog-update:
	cd debian && \
		DEBFULLNAME="$(AUTHOR)" \
		DEBEMAIL=$(AUTHOR_EMAIL) \
		EDITOR=enki \
			dch -v $(VERSION)-1~ppa1 -b --distribution lucid

dsc:
	rm -rf dist
	rm -rf build
	./setup.py sdist
	./scripts/make-deb.sh

dput: dsc
	cd build && dput monkeystudio *.changes

deb: dsc
	cd build/enki-$(VERSION) && debuild