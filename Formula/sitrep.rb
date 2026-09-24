class Sitrep < Formula
  desc "Source code analyzer giving a high-level overview of a Swift project"
  homepage "https://github.com/kikeenrique/Sitrep"
  license "Apache-2.0" => { with: "LLVM-exception" }

  # One universal (arm64+x86_64) macOS binary, shipped under two triple names so
  # arch-based downloaders resolve on either platform. Both tarballs wrap the same
  # binary and are written with `gzip -n`, so they are byte-identical and share
  # one sha256; Homebrew picks per-arch.
  on_macos do
    on_arm do
      url "https://github.com/kikeenrique/Sitrep/releases/download/4.1.0/sitrep-aarch64-apple-darwin.tar.gz"
      sha256 "88c88b0aac78871780830b44e241a2174e0224fc8989f41018867fbb73a7eba7"
    end
    on_intel do
      url "https://github.com/kikeenrique/Sitrep/releases/download/4.1.0/sitrep-x86_64-apple-darwin.tar.gz"
      sha256 "88c88b0aac78871780830b44e241a2174e0224fc8989f41018867fbb73a7eba7"
    end
  end

  # The release ships both a glibc and a musl Linux slice. We take musl, as in the
  # cmagic formula: built against the Swift Static Linux SDK it is fully static, so
  # it does not pin a minimum glibc the way the gnu slice does (that one is built
  # on RHEL UBI 9, hence GLIBC_2.34). Here musl is also the smaller of the two.
  on_linux do
    on_arm do
      url "https://github.com/kikeenrique/Sitrep/releases/download/4.1.0/sitrep-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b4467b7a78c0e61d744409bb33e6cde89d7650f571ac584def82823dc60fdd73"
    end
    on_intel do
      url "https://github.com/kikeenrique/Sitrep/releases/download/4.1.0/sitrep-x86_64-unknown-linux-musl.tar.gz"
      sha256 "704823278fec4cd3ed3bdf34f24a3818024f2ca1fafe1e7f84eaa4a9a71dc84a"
    end
  end

  def install
    bin.install "sitrep"
  end

  test do
    assert_match "USAGE: sitrep", shell_output("#{bin}/sitrep --help")
  end
end
