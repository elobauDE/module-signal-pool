# module-signal-pool

Dieses Repository enthält das ausgelagerte `signal_pool`-Modul aus dem Projekt `sdf-nga-jc-joystick`.

Zweck
- Das Modul soll als eigenständiges Git-Repository betrieben und anschließend als Submodul in das Hauptprojekt eingebunden werden.

Struktur
- `0_config/` : Konfigurationsdateien
- `1_source/srv/signal_pool/` : Quelldateien `signal_pool.c` und `signal_pool.h`

Schnellstart — GitHub / Remote erstellen und pushen

1) Lokales Repository initialisieren und pushen (Standard Git):

```bash
cd module-signal-pool
git init
git add .
git commit -m "Initial import: signal_pool module"
git branch -M main
# Remote hinzufügen (ersetzen Sie <OWNER> und ggf. https/ssh-URL):
git remote add origin git@github.com:<OWNER>/module-signal-pool.git
git push -u origin main
```

2) Alternativ mit GitHub CLI (falls installiert):

```bash
cd module-signal-pool
gh repo create <OWNER>/module-signal-pool --public --source=. --remote=origin --push
```

Als Submodul ins Hauptprojekt einbinden

Im Hauptprojekt-Repository (z.B. `sdf-nga-jc-joystick`) ausführen:

```bash
# ggf. vorhandenen Ordner sichern
git mv 1_source/srv/signal_pool 1_source/srv/signal_pool.bak
git commit -m "Move signal_pool for submodule"

# Submodul hinzufügen (ersetzen Sie <GIT_URL>):
git submodule add <GIT_URL> 1_source/srv/signal_pool
git commit -m "Add signal_pool as submodule"

git submodule update --init --recursive
```

Hinweise
- Prüfen Sie nach dem Umzug Includes und SCons-Konfigurationen, falls Pfade angepasst werden müssen.
- Die Quelldateien enthalten Copyright-Hinweise; behalten Sie diese bei.

Kontakt
- Bei Fragen zur Integration: Team/Projektverantwortliche des Hauptprojekts.