cask "aquaswmm" do
  version "0.12.3"
  sha256 "3ea11b4fc36264f253272065224bb3a14a797aea33b11248c6dca39c82d3e8bb"

  url "https://github.com/mf4633/aquaswmm-releases/releases/download/v#{version}/AquaSWMM-macos-universal.zip",
      verified: "github.com/mf4633/aquaswmm-releases/"
  name "AquaSWMM"
  desc "EPA SWMM model editor with 2D overland flow and storm-sewer design"
  homepage "https://aquaswmm.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "AquaSWMM.app"

  caveats <<~EOS
    AquaSWMM is commercial software with a free 30-day trial (no card):
      https://aquaswmm.com/download
    Without a licence key it opens in viewer mode: models and results open
    and display, while running, saving and exports need the trial or a licence.
    Releases up to 0.11.0 remain GPL-3.0-or-later.

    AquaSWMM is not signed or notarized, so macOS quarantines it on first
    launch and reports it as damaged or from an unidentified developer.
    Right-click AquaSWMM in Applications and choose Open once, or run:

      xattr -dr com.apple.quarantine /Applications/AquaSWMM.app

    Running a model on macOS needs EPA's command-line runner `runswmm` on
    your PATH (EPA ships it for Windows only; build it from EPA's source).
    Editing and viewing work without it.
  EOS

  zap trash: [
    "~/Library/Application Support/AquaSWMM",
    "~/Library/Application Support/StormSewer",
    "~/Library/Saved Application State/org.stormsewer.app.savedState",
  ]
end
