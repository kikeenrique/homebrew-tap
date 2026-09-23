class Cmagic < Formula
  desc "Inspect Codemagic builds and pull their artefacts from the terminal"
  homepage "https://github.com/kikeenrique/cmagic"

  # cmagic's release ships one universal (arm64+x86_64) macOS binary, published as
  # two byte-identical triple-named tarballs so arch-based downloaders resolve on
  # either platform. Both slices work on any macOS >= 13, so there is nothing to
  # build or bottle here — we install the released binary directly.
  on_macos do
    on_arm do
      url "https://github.com/kikeenrique/cmagic/releases/download/v0.4.1/cmagic-aarch64-apple-darwin.tar.gz"
      sha256 "4c6ac51f3397561f330e0b6cbd64c67e9234d819cc08eba732908d92d87c6d37"
    end
    on_intel do
      url "https://github.com/kikeenrique/cmagic/releases/download/v0.4.1/cmagic-x86_64-apple-darwin.tar.gz"
      sha256 "4c6ac51f3397561f330e0b6cbd64c67e9234d819cc08eba732908d92d87c6d37"
    end
  end

  # The release ships both a glibc and a musl Linux slice. Upstream treats glibc as
  # the primary artefact, but we take musl here: built against the Swift Static
  # Linux SDK it is fully static, so it neither pins a minimum glibc (the gnu slice
  # needs GLIBC_2.34) nor dlopens the host's libcurl for FoundationNetworking. The
  # two are within ~2 MB of each other since v0.4.1, so that robustness is free.
  on_linux do
    on_arm do
      url "https://github.com/kikeenrique/cmagic/releases/download/v0.4.1/cmagic-aarch64-unknown-linux-musl.tar.gz"
      sha256 "84c8459ca679269edcf057e6b55bb98f329000e783107c437fe4a7bff2e1775c"
    end
    on_intel do
      url "https://github.com/kikeenrique/cmagic/releases/download/v0.4.1/cmagic-x86_64-unknown-linux-musl.tar.gz"
      sha256 "16064b8d7376b63e55dc9ea55d8ae3a18908619908a94f845051eaba06220885"
    end
  end

  def install
    bin.install "cmagic"
  end

  test do
    assert_match "USAGE: cmagic", shell_output("#{bin}/cmagic --help")
  end
end
