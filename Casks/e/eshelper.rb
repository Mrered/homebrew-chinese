cask "eshelper" do
  version "11.6.0"
  sha256 "727d874fdb76b8e0f20054dd553e0b9700ccd93c037a74e9eb88aedc0174ab9d"

  url "https://static.eudic.net/pkg/ehmac.dmg?v=#{version}",
      user_agent: :fake
  name "Eshelper"
  name "西语助手"
  desc "西语学习者必备的工具"
  homepage "https://www.eudic.net/v4/es/app/eshelper"

  livecheck do
    url :homepage
    regex(/应用版本：(\d+(\.\d+)+)/i)
  end

  auto_updates true
  depends_on macos: ">= :high_sierra"

  app "Eudic_es.app"

  uninstall quit: [
    "com.eusoft.eshelper",
    "com.eusoft.eshelper.LightPeek",
    "com.eusoft.eshelper.QuickLook",
  ]

  zap trash: [
    "~/Library/Application Support/com.eusoft.eshelper",
    "~/Library/Caches/com.eusoft.eshelper",
    "~/Library/Caches/com.eusoft.eshelper.LightPeek",
    "~/Library/Containers/com.eusoft.eshelper.QuickLook",
    "~/Library/Eudb_es",
    "~/Library/Preferences/com.eusoft.eshelper.LightPeek.plist",
    "~/Library/Preferences/com.eusoft.eshelper.plist",
    "~/Library/Preferences/group.com.eusoft.eshelper.plist",
  ]
end
