class Manzanero < Formula
  desc "Control and inspect Apple devices from terminals and agents"
  homepage "https://github.com/kikeenrique/manzanero"
  url "https://github.com/kikeenrique/manzanero/releases/download/v0.1.0-beta.4/manzanero-aarch64-apple-darwin.tar.gz"
  version "0.1.0-beta.4"
  sha256 "8704bc6ba3f29d7a422d9f7503e2865923789cda9393bb1028b220719457e2ec"
  license "MIT"

  # Releases are GitHub prereleases, which the default strategy skips.
  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+(?:-[\w.]+)?)$/i)
    strategy :github_releases do |json, regex|
      json.filter_map do |release|
        next if release["draft"]

        release["tag_name"]&.[](regex, 1)
      end
    end
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe
  depends_on xcode: ["27.0", :run]

  def install
    # Signed with a Developer ID and notarized: install as-is, never modify or re-sign.
    # The executable finds bundled Swift libraries through @loader_path/lib, so it stays beside lib/.
    libexec.install "manzanero"
    libexec.install "lib" if File.directory?("lib")
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
    assert_match version.to_s, shell_output("#{bin}/manzanero --version")
    assert_match "Apple device tools", shell_output("#{bin}/manzanero --help")
  end
end
