cask "stormsewer" do
  version "0.9.4"
  sha256 "697ab274f2756e485a6f2194a1fc946a7049fbf7679e8218e9d06998d165369f"

  url "https://github.com/mf4633/stormsewer/releases/download/v#{version}/StormSewer-macos-universal.zip"
  name "StormSewer"
  desc "Storm sewer design and analysis for gravity pipe networks"
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
