class Manzanero < Formula
  desc "Control and inspect Apple devices from terminals and agents"
  homepage "https://github.com/kikeenrique/manzanero"
  version "0.1.0-beta.1"
  license "MIT"

  depends_on macos: :sequoia
  depends_on xcode: :run

  on_macos do
    on_arm do
      url "https://github.com/kikeenrique/manzanero/releases/download/v0.1.0-beta.1/manzanero-aarch64-apple-darwin.tar.gz"
      sha256 "480dcb4acbf32391ec48c3d5453b0c4617526fbd5af54490bfd9384be4f00b8f"
    end
    on_intel do
      url "https://github.com/kikeenrique/manzanero/releases/download/v0.1.0-beta.1/manzanero-x86_64-apple-darwin.tar.gz"
      sha256 "480dcb4acbf32391ec48c3d5453b0c4617526fbd5af54490bfd9384be4f00b8f"
    end
  end

  def install
    libexec.install "manzanero", "lib"
    bin.install_symlink libexec/"manzanero"
    pkgshare.install "ThirdParty", "beta-testing.md", "license"
  end

  def caveats
    <<~EOS
      Beta: device controls use installed Apple developer frameworks.
      Select a full Xcode installation and run manzanero doctor.
      Physical UI testing needs pairing, Developer Mode and Enable UI Automation.
      Native video requires macOS 26 or later. See the installed beta-testing.md.
    EOS
  end

  test do
    assert_match "0.1.0-beta.1", shell_output("#{bin}/manzanero --version")
    assert_match "Apple device tools", shell_output("#{bin}/manzanero --help")
  end
end
