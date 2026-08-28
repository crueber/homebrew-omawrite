class Omawrite < Formula
  desc "Dead-simple Markdown writing app built with Qt Quick"
  homepage "https://github.com/omacom/omawrite"
  url "https://github.com/omacom/omawrite/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "b57e418212f9bde0b8a12cff2424a43f15829a56a58fdc49542a0393a430f938"
  license "MIT"

  head "https://github.com/omacom/omawrite.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "qt"

  def install
    system "qmake", "omawrite.pro"
    system "make"

    if OS.mac?
      prefix.install "omawrite.app"
      bin.install_symlink prefix/"omawrite.app/Contents/MacOS/omawrite" => "omawrite"
    else
      bin.install "omawrite"
    end
  end

  test do
    assert_path_exists bin/"omawrite"
    if OS.mac?
      assert_path_exists prefix/"omawrite.app/Contents/MacOS/omawrite"
    end
  end
end
