cask "margin" do
  version "1.0.0"
  sha256 "7ec9273bb01129c798896b94c27f3808245106b457704ad64a6255d8df90ef4a"

  url "https://github.com/bluepi0j/margin/releases/download/v#{version}/Margin-#{version}.zip"
  name "Margin"
  desc "Lightweight Markdown editor"
  homepage "https://github.com/bluepi0j/margin"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Margin.app"

  # Margin is not notarized (no Apple Developer ID), so macOS would refuse to
  # open it the first time; lift that for the copy Homebrew put in
  # /Applications. With a custom --appdir this step is skipped and macOS asks
  # once instead.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "Margin.app"], chdir: "/Applications",
                          must_succeed: false, print_stderr: false
  end

  zap trash: [
    "~/Library/Application Support/Margin",
    "~/Library/Caches/app.margin.Margin",
    "~/Library/HTTPStorages/app.margin.Margin",
    "~/Library/Preferences/app.margin.Margin.plist",
    "~/Library/Saved Application State/app.margin.Margin.savedState",
    "~/Library/WebKit/app.margin.Margin",
  ]
end
