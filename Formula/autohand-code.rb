class AutohandCode < Formula
  desc "Autonomous LLM-powered coding agent CLI"
  homepage "https://autohand.ai"
  version "0.9.4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.4/autohand-macos-arm64.tar.gz"
      sha256 "bee09d3deb3e8dbb953c7a2445e2dfe8897445ed6fd314919d74e877e8c0327f"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.4/autohand-macos-x64.tar.gz"
      sha256 "cb2518c86e5a109bda63fe481f1a6b9cd79a82a8825044fb8ad68b9122fd85c4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.4/autohand-linux-arm64.tar.gz"
      sha256 "3f19503b2aad498bb60fcd7b44a422f3dd82b965ce0722897459ad9ff3a6e1f6"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.4/autohand-linux-x64.tar.gz"
      sha256 "0c8904708b9bc51e27ad23055a8f2b143687ad5252ca686e79d7b70fd99c3141"
    end
  end

  def install
    bin.install "autohand"
    bin.install_symlink "autohand" => "autohand-code"
    bin.install_symlink "autohand" => "agent"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/autohand --version")
  end
end
