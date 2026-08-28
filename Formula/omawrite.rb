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
  on_macos do
    depends_on "librsvg" => :build
  end

  def install
    if OS.mac?
      # Upstream wires the SVG icon into Linux icon themes only; generate an
      # .icns so the macOS app bundle gets a Dock/Finder icon.
      system "rsvg-convert", "-w", "1024", "-h", "1024",
             "pkgbuild/omawrite.svg", "-o", "icon1024.png"
      mkdir "omawrite.iconset"
      %w[16 32 128 256 512].each do |s|
        system "sips", "-z", s, s, "icon1024.png",
               "--out", "omawrite.iconset/icon_#{s}x#{s}.png"
        s2 = (s.to_i * 2).to_s
        system "sips", "-z", s2, s2, "icon1024.png",
               "--out", "omawrite.iconset/icon_#{s}x#{s}@2x.png"
      end
      system "iconutil", "-c", "icns", "omawrite.iconset",
             "-o", "pkgbuild/omawrite.icns"
      inreplace "omawrite.pro", "RESOURCES += src/resources.qrc",
                "RESOURCES += src/resources.qrc\n\nmacx {\n    ICON = " \
                "pkgbuild/omawrite.icns\n}"
    end

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
