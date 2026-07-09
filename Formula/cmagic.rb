class Cmagic < Formula
  desc "Inspect Codemagic builds and pull their artefacts from the terminal"
  homepage "https://github.com/kikeenrique/cmagic"
  version "0.1.0"

  # cmagic's release ships one universal (arm64+x86_64) binary, published as two
  # byte-identical triple-named tarballs so arch-based downloaders resolve on
  # either platform. Both slices work on any macOS >= 13, so there is nothing to
  # build or bottle here — we install the released binary directly.
  on_macos do
    on_arm do
      url "https://github.com/kikeenrique/cmagic/releases/download/v0.1.0/cmagic-aarch64-apple-darwin.tar.gz"
      sha256 "ee7ddf4af723587bc35a8fb357af103cfbe46c0218d4b497bb10a71206999a14"
    end
    on_intel do
      url "https://github.com/kikeenrique/cmagic/releases/download/v0.1.0/cmagic-x86_64-apple-darwin.tar.gz"
      sha256 "ee7ddf4af723587bc35a8fb357af103cfbe46c0218d4b497bb10a71206999a14"
    end
  end

  def install
    bin.install "cmagic"
  end

  test do
    assert_match "USAGE: cmagic", shell_output("#{bin}/cmagic --help")
  end
end
