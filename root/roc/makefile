DEST=/opt/roc/
CONFDEST=/etc/opt/roc/
ETCDEST=/etc/init.d/
SRC=./src/
SCRIPT=./scripts_init.d/
CONF=./config_generic/

all: $(DEST)roc $(DEST)zephyr
#	cp $(CONF)* $(CONFDEST)
	cp $(SCRIPT)* $(ETCDEST)
	cp $(SRC)gpio $(DEST)

$(DEST)roc: $(SRC)roc2.o
ifeq (,$(wildcard $(DEST)roc))
else
	rm $(DEST)roc
endif
	gcc -o $(DEST)roc $(SRC)roc2.o -lconfig
$(SRC)roc2.o: $(SRC)roc2.c
ifeq (,$(wildcard $(SRC)roc2.o))
else
	rm $(SRC)roc2.o
endif
	gcc -MMD $(SRC)roc2.c -O0 -c -o $(SRC)roc2.o

$(DEST)zephyr: $(SRC)zephyr.o
ifeq (,$(wildcard $(DEST)zephyr))
else
	rm $(DEST)zephyr
endif
	gcc -o $(DEST)zephyr $(SRC)zephyr.o -lconfig
$(SRC)zephyr.o: $(SRC)zephyr.c
ifeq (,$(wildcard $(SRC)zephyr.o))
else
	rm $(SRC)zephyr.o
endif
	gcc -MMD $(SRC)zephyr.c -O0 -c -o $(SRC)zephyr.o

