cask "omawrite" do
  version "0.5.0"
  sha256 "f64c8718fdc50c2fa51cc395cff78da61443fd5f317e56c8c8da60ac2db06d55"

  url "https://github.com/crueber/omawrite/releases/download/v#{version}/omawrite-#{version}-macos.zip",
      verified: "github.com/crueber/omawrite/"
  name "omawrite"
  desc "Dead-simple Markdown writing app built with Qt Quick"
  homepage "https://github.com/omacom/omawrite"

  depends_on arch: :arm64
  depends_on :macos

  app "omawrite.app"
end
