class Axe < Formula
  desc "CLI tool for interacting with iOS Simulators via accessibility and HID APIs"
  homepage "https://github.com/kikeenrique/AXe"
  # Explicit version: Homebrew parses the v1.9.0-prerelease.N tag in the URL as plain
  # 1.9.0, so without it `brew upgrade` would not see a new prerelease.N.
  url "https://github.com/kikeenrique/AXe/releases/download/v1.9.0-prerelease.1/axe-aarch64-apple-darwin.tar.gz"
  version "1.9.0-prerelease.1"
  sha256 "cf56d0270ac2fe5b39786faa285a00c90d797d85eda623e6c4eaebc95c43722c"
  license "MIT"

  # The kikeenrique/AXe fork's release pipeline publishes this archive unsigned. IDB is
  # linked statically, so the payload is arm64-only: axe, its resource bundle, and the
  # in-simulator helper under Resources/, kept beside axe in libexec where it looks for
  # them. Only axe is signed (ad hoc) here: Apple silicon refuses unsigned code. The
  # helper runs inside the simulator and keeps the signature it was built with. This
  # sits in install rather than post_install, which Homebrew has deprecated in favour of
  # post_install_steps, a declarative DSL that cannot run codesign.
  depends_on arch: :arm64
  depends_on macos: :sequoia

  def install
    libexec.install "axe", "AXe_AXe.bundle", "Resources"
    system "codesign", "--force", "--sign", "-", "--timestamp=none", libexec/"axe"
    bin.write_exec_script libexec/"axe"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/axe --version")
  end
end
