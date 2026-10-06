class AquaswmmCli < Formula
  desc "Storm sewer network hydrology and hydraulics from the command line"
  homepage "https://aquaswmm.com/"
  license "GPL-3.0-or-later"

  # No `version` stanza: Homebrew scans it from the URL, and `brew audit
  # --strict` rejects the redundancy. Bump the tag in both URLs to update.
  on_macos do
    url "https://github.com/mf4633/aquaswmm-releases/releases/download/v0.12.4/aquaswmm-cli-macos.tar.gz"
    sha256 "3d83599eff848c584a9fc4b97771ed6c3064f4ad2d56bef4803197def44117d0"
  end

  on_linux do
    on_intel do
      url "https://github.com/mf4633/aquaswmm-releases/releases/download/v0.12.4/aquaswmm-cli-linux-x64.tar.gz"
      sha256 "7705f67cad03bc0862687040814f781fbdde30d12c97ec929596691af11ed75f"
    end
  end

  livecheck do
    url "https://github.com/mf4633/aquaswmm-releases/releases/latest"
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
