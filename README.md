# mf4633/homebrew-tap

Homebrew packages for engineering tools by [Michael Flynn, PE](https://github.com/mf4633).

```sh
brew tap mf4633/tap
```

## StormSewer — the desktop app

Free, open-source storm sewer design and analysis for gravity pipe networks:
Rational method hydrology, Manning capacity for circular, box, elliptical and
arch conduits, standard-step HGL/EGL backwater, HEC-22 inlets with bypass
carryover, auto-sizing, and submittal PDF reports.

```sh
brew install --cask mf4633/tap/stormsewer
```

macOS only, universal (Apple Silicon and Intel). The app is **not signed or
notarized**, so macOS quarantines it on first launch and calls it damaged or
unidentified. Either right-click it in Applications and choose Open once, or:

```sh
xattr -dr com.apple.quarantine /Applications/StormSewer.app
```

Do that only because you trust the source. Code signing is on the roadmap.

Windows and Linux users want the [GitHub release](https://github.com/mf4633/stormsewer/releases/latest)
instead — a Windows installer (`winget install MichaelFlynn.StormSewer` once the
manifest merges), a Linux AppImage, and a tarball. There is also a browser build
at [mf4633.github.io/stormsewer](https://mf4633.github.io/stormsewer/) that needs
no install at all.

## stormsewer-cli — the command-line analyzer

Analyzes a `.ssn` network file and prints pipe and structure schedules. macOS
(universal) and Linux x86-64.

```sh
brew install mf4633/tap/stormsewer-cli
stormsewer-cli network.ssn
```

A minimal network file:

```
IDF        60 10 0.8
TAILWATER  100.5
MINTC      10

#    id   kind      x    y   invert  rim    area  C     tc
NODE N1   inlet     0    0   104.0   110.0  1.0   0.70  12
NODE OUT  outfall   300  0   101.0   107.0

#    id   from to   length  dia   n
PIPE P1   N1   OUT  300     1.25  0.013
```

The engine is also a Rust crate — `cargo add stormsewer` — and compiles to
WebAssembly.

## Updating a package

Bump `version` and the `sha256` values after a release:

```sh
gh release download vX.Y.Z -R mf4633/stormsewer \
  -p "StormSewer-macos-universal.zip" \
  -p "stormsewer-cli-macos.tar.gz" \
  -p "stormsewer-cli-linux-x64.tar.gz"
shasum -a 256 StormSewer-macos-universal.zip stormsewer-cli-*.tar.gz
brew audit --tap mf4633/tap --strict stormsewer stormsewer-cli
```

## Why a personal tap

Homebrew's own cask repository requires a project to clear a notability bar
(roughly 75 stars, 30 forks, or 30 watchers) before it will accept a new
submission. StormSewer is newer than that. A personal tap works identically for
anyone who taps it, and the packages can move upstream later.

## License

The packaged software is GPL-3.0-or-later. These packaging files are MIT.
