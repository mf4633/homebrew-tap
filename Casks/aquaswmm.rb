cask "aquaswmm" do
  version "0.11.0"
  sha256 "ab072801a57f9cbbbaec40f79b023153ee55ef41cdfc268fd2377386c89fc870"

  url "https://github.com/mf4633/stormsewer/releases/download/v#{version}/AquaSWMM-macos-universal.zip"
  name "AquaSWMM"
  desc "Storm sewer design and EPA SWMM model editor with 2D overland flow"
  homepage "https://github.com/mf4633/stormsewer"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "AquaSWMM.app"

  caveats <<~EOS
    AquaSWMM is not signed or notarized, so macOS quarantines it on first
    launch and reports it as damaged or from an unidentified developer.

    To run it, either right-click AquaSWMM in Applications and choose Open
    once, or clear the quarantine attribute yourself:

      xattr -dr com.apple.quarantine /Applications/AquaSWMM.app

    Only do that because you trust the source. Code signing is on the roadmap.
  EOS

  zap trash: [
    "~/Library/Application Support/AquaSWMM",
    "~/Library/Application Support/StormSewer",
    "~/Library/Saved Application State/org.stormsewer.app.savedState",
  ]
end
