class AquaswmmCli < Formula
  desc "Storm sewer network hydrology and hydraulics from the command line"
  homepage "https://github.com/mf4633/stormsewer"
  license "GPL-3.0-or-later"

  # No `version` stanza: Homebrew scans it from the URL, and `brew audit
  # --strict` rejects the redundancy. Bump the tag in both URLs to update.
  on_macos do
    url "https://github.com/mf4633/stormsewer/releases/download/v0.11.0/aquaswmm-cli-macos.tar.gz"
    sha256 "7fff56c4e37329ea59d8915de8a084a5105659558d52dfd1d615eb0d5e23431e"
  end

  on_linux do
    on_intel do
      url "https://github.com/mf4633/stormsewer/releases/download/v0.11.0/aquaswmm-cli-linux-x64.tar.gz"
      sha256 "85d05eabdea5770711a960b493fa0913a16b8abd44697f8f274487da46106d5f"
    end
  end

  livecheck do
    url "https://github.com/mf4633/stormsewer/releases/latest"
    strategy :github_latest
  end

  def install
    bin.install "aquaswmm-cli"
  end

  test do
    # A two-structure run: one inlet draining to an outfall through 100 ft of
    # 18-inch pipe. The CLI must analyze it and report the pipe.
    (testpath/"net.ssn").write <<~EOS
      NODE N1 inlet 0 100 96.0 104.0 1.0 0.7 10.0
      NODE OUT outfall 100 100 95.0 103.0
      PIPE P1 N1 OUT 100.0 1.5 0.013
    EOS
    output = shell_output("#{bin}/aquaswmm-cli #{testpath}/net.ssn")
    assert_match "P1", output
  end
end
