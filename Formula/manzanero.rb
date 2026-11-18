class Manzanero < Formula
  desc "Control and inspect Apple devices from terminals and agents"
  homepage "https://github.com/kikeenrique/manzanero"
  url "https://github.com/kikeenrique/manzanero/releases/download/v0.1.0-beta.1/manzanero-aarch64-apple-darwin.tar.gz"
  version "0.1.0-beta.1"
  sha256 "480dcb4acbf32391ec48c3d5453b0c4617526fbd5af54490bfd9384be4f00b8f"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :tahoe
  depends_on xcode: ["27.0", :run]

  def install
    libexec.install "manzanero", "lib"
    bin.install_symlink libexec/"manzanero"
    pkgshare.install "ThirdParty", "beta-testing.md", "license"
  end

  def caveats
    <<~EOS
      Beta: device controls use installed Apple developer frameworks.
      Select Xcode 27 or later (macOS 26.6 or later) and run manzanero doctor.
      Physical UI testing needs pairing, Developer Mode and Enable UI Automation.
      See the installed beta-testing.md.
    EOS
  end

  test do
    assert_match "0.1.0-beta.1", shell_output("#{bin}/manzanero --version")
    assert_match "Apple device tools", shell_output("#{bin}/manzanero --help")
  end
end
