include pgxntool/base.mk

cat_tools: $(DESTDIR)$(datadir)/extension/cat_tools.control
$(DESTDIR)$(datadir)/extension/cat_tools.control:
	pgxn install cat_tools

GENERATED = $(subst meta,generated,$(wildcard meta/*.sql))

.PHONY: generated
generated: $(GENERATED)
.PHONY: meta
meta: generated
all: generated
generated/%.sql: meta/%.sql cat_tools 
	@echo 'Generating $@ from $<'
	@echo '-- THIS IS A GENERATED FILE. DO NOT EDIT!' > $@
	@echo >> $@
	@psql -qt -P format=unaligned --no-psqlrc -v ON_ERROR_STOP=1 -f $< >> $@

.PHONY: genclean
genclean:
	@rm $(GENERATED)

sql/%.sql: build/%.sh $(GENERATED)
	$< > $@
