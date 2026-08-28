cask "omawrite" do
  version "0.5.0"
  sha256 "5633e4b8f5753f229f1a5d4c8f6504131be0c7b3249a1741219e083cd17cce0a"

  url "https://github.com/crueber/omawrite/releases/download/v#{version}/omawrite-#{version}-macos.zip",
      verified: "github.com/crueber/omawrite/"
  name "omawrite"
  desc "Dead-simple Markdown writing app built with Qt Quick"
  homepage "https://github.com/omacom/omawrite"

  depends_on arch: :arm64
  depends_on :macos

  app "omawrite.app"
end
