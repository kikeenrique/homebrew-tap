class Cmagic < Formula
  desc "Inspect Codemagic builds and pull their artefacts from the terminal"
  homepage "https://github.com/kikeenrique/cmagic"

  # cmagic's release ships one universal (arm64+x86_64) macOS binary, published as
  # two byte-identical triple-named tarballs so arch-based downloaders resolve on
  # either platform. Both slices work on any macOS >= 13, so there is nothing to
  # build or bottle here — we install the released binary directly.
  on_macos do
    on_arm do
      url "https://github.com/kikeenrique/cmagic/releases/download/v0.4.2/cmagic-aarch64-apple-darwin.tar.gz"
      sha256 "75ac85449686b907ba6c41109b36a58d58514bc92ade5b5b59d4ec872204579f"
    end
    on_intel do
      url "https://github.com/kikeenrique/cmagic/releases/download/v0.4.2/cmagic-x86_64-apple-darwin.tar.gz"
      sha256 "75ac85449686b907ba6c41109b36a58d58514bc92ade5b5b59d4ec872204579f"
    end
  end

  # The release ships both a glibc and a musl Linux slice. Upstream treats glibc as
  # the primary artefact, but we take musl here: built against the Swift Static
  # Linux SDK it is fully static, so it neither pins a minimum glibc (the gnu slice
  # needs GLIBC_2.34) nor dlopens the host's libcurl for FoundationNetworking. The
  # two are within ~2 MB of each other since v0.4.1, so that robustness is free.
  on_linux do
    on_arm do
      url "https://github.com/kikeenrique/cmagic/releases/download/v0.4.2/cmagic-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f4d8951df8225790b4fdc82cdfaf09bcd5136c64f562a5865e352bdff9525eb4"
    end
    on_intel do
      url "https://github.com/kikeenrique/cmagic/releases/download/v0.4.2/cmagic-x86_64-unknown-linux-musl.tar.gz"
      sha256 "922b921b576334d8f0d012ee57cb20ae0c7f64f5c34ad4a2ae00775182a1560e"
    end
  end

  def install
    bin.install "cmagic"
  end

  test do
    assert_match "USAGE: cmagic", shell_output("#{bin}/cmagic --help")
  end
end
