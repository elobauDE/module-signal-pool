# module-signal-pool

Dieses Repository kapselt das Signal-Pool-Modul als eigenstaendiges Submodul.
Der Fokus liegt auf einer einfachen Einbindung in Embedded-Projekte mit klarer
Trennung von Modulcode und projektspezifischer Konfiguration.

## Was das Modul beinhaltet

- Signal-Speicher mit typisierten Signalen (`uint32`, `float32`)
- Zugriffsfunktionen zum Setzen, Lesen und Mappen von Signalen
- Pruefungen auf gueltigen Bereich und gueltigen Datentyp

Quellen:
- `1_source/srv/signal_pool/signal_pool.c`
- `1_source/srv/signal_pool/signal_pool.h`

## Repository-Struktur

- `0_config/`
	- Platz fuer projektspezifische Konfiguration (z. B. Signal-Range-Definitionen)
- `1_source/srv/signal_pool/`
	- Modulimplementierung (`signal_pool.c`, `signal_pool.h`)

## Einbindung in ein Projekt

Empfohlene Einbindung als Git-Submodul unter `1_source/ext/module-signal-pool`:

```bash
git submodule add https://github.com/elobauDE/module-signal-pool.git 1_source/ext/module-signal-pool
git submodule update --init --recursive
```

Falls das Submodul bereits in `.gitmodules` eingetragen ist:

```bash
git submodule sync --recursive
git submodule update --init --recursive
```

## Build-/Include-Integration

Damit das Modul im Zielprojekt gebaut wird, sind in der Regel zwei Punkte noetig:

- Include-Pfad auf den Header setzen:
	- `1_source/ext/module-signal-pool/1_source/srv/signal_pool`
- Modulquelle in den Build aufnehmen:
	- `1_source/ext/module-signal-pool/1_source/srv/signal_pool/signal_pool.c`

## Externe Abhaengigkeiten

Das Modul erwartet folgende projektspezifische Header/Typen:

- `signal_pool_cfg.h`
	- Konfigurationsdaten und Bereichsfunktionen
	- z. B. `SP_NR_OF_MEM_CELLS`, `sp_cfg_get_range_begin/end/size(...)`
- `util_float.h`
	- Definition von `float32_t`

Diese Dateien werden typischerweise im Hauptprojekt bereitgestellt.

## Oeffentliche API (Kurzuebersicht)

- Initialisierung:
	- `sp_init_range(...)`
- Typkonfiguration:
	- `set_signal_type(...)`
- Float-Zugriff:
	- `get_signal_float(...)`, `set_signal_float(...)`
	- `map_raw_float_ro(...)`, `map_raw_float_rw(...)`
- Uint32-Zugriff:
	- `get_signal_uint32(...)`, `set_signal_uint32(...)`
	- `map_raw_uint32_ro(...)`, `map_raw_uint32_rw(...)`

## Hinweise

- Bei Pfadaenderungen nach der Integration Includes und Build-Skripte pruefen.
- Vorhandene Copyright-/Lizenzhinweise in den Quelldateien beibehalten.