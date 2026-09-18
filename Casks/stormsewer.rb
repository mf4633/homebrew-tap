cask "stormsewer" do
  version "0.10.0"
  sha256 "721c00816e618c43b2dbea0d62b6851747ab079ae8ae4c771d4ee7082bc49ca0"

  url "https://github.com/mf4633/stormsewer/releases/download/v#{version}/StormSewer-macos-universal.zip"
  name "StormSewer"
  desc "Storm sewer design and EPA SWMM model editor with 2D overland flow"
  homepage "https://github.com/mf4633/stormsewer"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "StormSewer.app"

  caveats <<~EOS
    StormSewer is not signed or notarized, so macOS quarantines it on first
    launch and reports it as damaged or from an unidentified developer.

    To run it, either right-click StormSewer in Applications and choose Open
    once, or clear the quarantine attribute yourself:

      xattr -dr com.apple.quarantine /Applications/StormSewer.app

    Only do that because you trust the source. Code signing is on the roadmap.
  EOS

  zap trash: [
    "~/Library/Application Support/StormSewer",
    "~/Library/Saved Application State/org.stormsewer.app.savedState",
  ]
end
