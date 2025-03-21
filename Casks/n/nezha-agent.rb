cask "nezha-agent" do
  arch arm: "arm64", intel: "amd64"
  os macos: "darwin", linux: "linux"

  version "1.9.6"
  sha256 arm:          "1731d9267b7815df73ffacd3c952d67e869d9f28cc5f0864272758a308e06c12",
         x86_64:       "d67d93622fb1ce7156c21dee09258e071e127ee9b5430661d4b340a22d0dc0d8",
         arm64_linux:  "592008995d39aabfb3a313da86ffc4fecc4e2aea8ab0295006c8706d299c5f5b",
         x86_64_linux: "56a40362b8c8b5b47238932a76dc880d3a7a749c0b1c6626f66549dd5a27381f"

  url "https://github.com/nezhahq/agent/releases/download/v#{version}/nezha-agent_#{os}_#{arch}.zip",
      verified: "github.com/nezhahq/agent/"
  name "nezha-agent"
  desc "哪吒监控服务"
  homepage "https://nezha.wiki/"

  livecheck do
    url "https://github.com/nezhahq/agent"
    strategy :github_latest
  end

  binary "nezha-agent"
  service do
    run [opt_bin/"nezha-agent", "--password", ENV["HOMEBREW_NEZHA_AGENT_PASSWORD"].to_s, "--server",
         ENV["HOMEBREW_NEZHA_AGENT_SERVER"].to_s]
    keep_alive true
    environment_variables({
      HOMEBREW_NEZHA_AGENT_PASSWORD: ENV.fetch("HOMEBREW_NEZHA_AGENT_PASSWORD", nil),
      HOMEBREW_NEZHA_AGENT_SERVER:   ENV.fetch("HOMEBREW_NEZHA_AGENT_SERVER", nil),
    })
  end

  def caveats
    <<~EOS
      请先添加环境变量
        echo 'export HOMEBREW_NEZHA_AGENT_PASSWORD="你的密钥，在你的服务页面获取"' >> ~/.zshrc
        echo 'export HOMEBREW_NEZHA_AGENT_SERVER="你的服务器和端口，格式 your.domain:5555 "' >> ~/.zshrc
        source ~/.zshrc
      再安装本命令行服务，否则会导致无法向服务配置中初始化密钥和服务器参数。

      若已安装，并遇到错误，则请运行
        brew services stop nezha-agent
        brew reinstall nezha-agent
        brew services start nezha-agent
    EOS
  end
end
