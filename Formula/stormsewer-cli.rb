class StormsewerCli < Formula
  desc "Storm sewer network hydrology and hydraulics from the command line"
  homepage "https://github.com/mf4633/stormsewer"
  version "0.9.2"
  license "GPL-3.0-or-later"

  on_macos do
    url "https://github.com/mf4633/stormsewer/releases/download/v#{version}/stormsewer-cli-macos.tar.gz"
    sha256 "6c5db793af827a26bae72ad3c85c3314b60e1f114e3ea8f589cbdb591ef66e55"
  end

  on_linux do
    on_intel do
      url "https://github.com/mf4633/stormsewer/releases/download/v#{version}/stormsewer-cli-linux-x64.tar.gz"
      sha256 "982dfc0ce32d36441f5bddc18f89078cb5ee597684c1b9fe26eec038665d0a7e"
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
