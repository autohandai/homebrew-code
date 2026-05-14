class AutohandCode < Formula
  desc "Autonomous LLM-powered coding agent CLI"
  homepage "https://autohand.ai"
  version "0.9.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.1/autohand-macos-arm64.tar.gz"
      sha256 "b19943b5d89926cc7af5759c75a87912459343ce3b915ef83c23c4c86446cf86"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.1/autohand-macos-x64.tar.gz"
      sha256 "51bbf34e60a0db950176cd5fb337240536e33b093967064428206b068cd1ae00"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.1/autohand-linux-arm64.tar.gz"
      sha256 "fe2042ac3f9fcdc68ce88256b8231b1d167ea37658f518f3540a91fa6175d4cf"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.1/autohand-linux-x64.tar.gz"
      sha256 "a4c9f0a01c88f6354ab8a293f132cd1fb505f4ec91181d4acdbccbde4febdd9b"
    end
  end

  def install
    bin.install "autohand" => "autohand-code"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/autohand-code --version")
  end
end
