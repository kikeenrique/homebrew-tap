class GoSwifty < Formula
  desc "Measure Swift coverage in a project"
  homepage "https://github.com/kikeenrique/GoSwifty"
  url "https://github.com/kikeenrique/GoSwifty/archive/refs/tags/1.0.0.tar.gz"
  sha256 "1a5644967d37dd3de8d50b74f0778f04214f9f7219390b210712f1676c04708f"

  depends_on xcode: ["11.4", :build]

  def install
    system "swift", "build", "--configuration", "release", "--disable-sandbox"
    bin.install ".build/release/GoSwifty" => "go-swifty"
  end

  test do
    assert_match "USAGE: go-swifty", shell_output("#{bin}/go-swifty --help")
  end
end
