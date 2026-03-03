class AutohandCode < Formula
  desc "Autonomous LLM-powered coding agent CLI"
  homepage "https://autohand.ai"
  version "0.8.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v#{version}/autohand-macos-arm64.tar.gz"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v#{version}/autohand-macos-x64.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v#{version}/autohand-linux-arm64.tar.gz"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v#{version}/autohand-linux-x64.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    bin.install "autohand" => "autohand-code"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/autohand-code --version")
  end
end
