class Cmagic < Formula
  desc "Inspect Codemagic builds and pull their artefacts from the terminal"
  homepage "https://github.com/kikeenrique/cmagic"
  version "0.2.0"

  # cmagic's release ships one universal (arm64+x86_64) binary, published as two
  # byte-identical triple-named tarballs so arch-based downloaders resolve on
  # either platform. Both slices work on any macOS >= 13, so there is nothing to
  # build or bottle here — we install the released binary directly.
  on_macos do
    on_arm do
      url "https://github.com/kikeenrique/cmagic/releases/download/v0.2.0/cmagic-aarch64-apple-darwin.tar.gz"
      sha256 "cc07bfa1c4d1f6f7f6ed91d15da941e155142af10c94aacbce35304c14536030"
    end
    on_intel do
      url "https://github.com/kikeenrique/cmagic/releases/download/v0.2.0/cmagic-x86_64-apple-darwin.tar.gz"
      sha256 "cc07bfa1c4d1f6f7f6ed91d15da941e155142af10c94aacbce35304c14536030"
    end
  end

  def install
    bin.install "cmagic"
  end

  test do
    assert_match "USAGE: cmagic", shell_output("#{bin}/cmagic --help")
  end
end
