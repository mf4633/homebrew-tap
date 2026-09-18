class StormsewerCli < Formula
  desc "Storm sewer network hydrology and hydraulics from the command line"
  homepage "https://github.com/mf4633/stormsewer"
  license "GPL-3.0-or-later"

  # No `version` stanza: Homebrew scans it from the URL, and `brew audit
  # --strict` rejects the redundancy. Bump the tag in both URLs to update.
  on_macos do
    url "https://github.com/mf4633/stormsewer/releases/download/v0.10.0/stormsewer-cli-macos.tar.gz"
    sha256 "280c18b98d4f43f8eef205129e96b13c55dc1a2ddc8ca40d5fec94b1a9506422"
  end

  on_linux do
    on_intel do
      url "https://github.com/mf4633/stormsewer/releases/download/v0.10.0/stormsewer-cli-linux-x64.tar.gz"
      sha256 "46d0d3e0b94cc1faf25ecb28fcf4cd9623b847a42681b2618feb890e4ed63f89"
    end
  end

  livecheck do
    url "https://github.com/mf4633/stormsewer/releases/latest"
    strategy :github_latest
  end

  def install
    bin.install "stormsewer-cli"
  end

  test do
    # A two-structure run: one inlet draining to an outfall through 100 ft of
    # 18-inch pipe. The CLI must analyze it and report the pipe.
    (testpath/"net.ssn").write <<~EOS
      NODE N1 inlet 0 100 96.0 104.0 1.0 0.7 10.0
      NODE OUT outfall 100 100 95.0 103.0
      PIPE P1 N1 OUT 100.0 1.5 0.013
    EOS
    output = shell_output("#{bin}/stormsewer-cli #{testpath}/net.ssn")
    assert_match "P1", output
  end
end
