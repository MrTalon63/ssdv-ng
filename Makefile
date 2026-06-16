VERSION?=DEV

ifeq ($(OS),Windows_NT)
  CLEAN_CMD = if exist build rmdir /s /q build
  CHMOD_CMD = @rem
else
  CLEAN_CMD = rm -rf build
  CHMOD_CMD = chmod +x
endif

.PHONY: all clean install

all:
	cmake -B build -DVERSION="$(VERSION)" -DCMAKE_BUILD_TYPE=Release -Wno-dev --no-warn-unused-cli
	cmake --build build --config Release
	-$(CHMOD_CMD) build/bin/ssdv
	-$(CHMOD_CMD) build/bin/ssdv-gui


install: all
	mkdir -p $(DESTDIR)/usr/bin
	install -m 755 build/bin/ssdv $(DESTDIR)/usr/bin
	install -m 755 build/bin/ssdv-gui $(DESTDIR)/usr/bin

clean:
	$(CLEAN_CMD)