class Omawrite < Formula
  desc "Dead-simple Markdown writing app built with Qt Quick"
  homepage "https://github.com/omacom/omawrite"
  url "https://github.com/omacom/omawrite/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "498d310b0a94beba05501ed8442019ca76f1750150f3bcd809a7307b78b038bc"
  license "MIT"

  head "https://github.com/omacom/omawrite.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "qtbase"
  depends_on "qtdeclarative"

  def install
    system "qmake", "omawrite.pro"
    system "make"

    if OS.mac?
      # Source builds install the bare binary; the packaged GUI app with its
      # bundle, icon and framework self-containment comes from the cask.
      bin.install "omawrite.app/Contents/MacOS/omawrite"
    else
      bin.install "omawrite"
    end
  end

  test do
    assert_path_exists bin/"omawrite"
  end
end
