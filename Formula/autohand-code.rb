class AutohandCode < Formula
  desc "Autonomous LLM-powered coding agent CLI"
  homepage "https://autohand.ai"
  version "0.8.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.8.2/autohand-macos-arm64.tar.gz"
      sha256 "3bd5bfd9584852cceab42246f386af0a8a049cf78240bf9e7ee95add45718171"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.8.2/autohand-macos-x64.tar.gz"
      sha256 "98a609dab064b06a1c5c77ea167f07772ae60448d044dcc7a9aa2808e79b72ba"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.8.2/autohand-linux-arm64.tar.gz"
      sha256 "af19e52edffe2fd6946c766bffba458bbdab22999b7d43e983aac33830beced7"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.8.2/autohand-linux-x64.tar.gz"
      sha256 "f40000633a86f4a52a5c58297e03b8e4b62385d0271dda2f27785281ea3da690"
    end
  end

  def install
    bin.install "autohand" => "autohand-code"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/autohand-code --version")
  end
end
