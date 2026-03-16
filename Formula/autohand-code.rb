class AutohandCode < Formula
  desc "Autonomous LLM-powered coding agent CLI"
  homepage "https://autohand.ai"
  version "0.8.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.8.3/autohand-macos-arm64.tar.gz"
      sha256 "4dbe6ebadb27c73e6c1482561c8a070f5011624b9e582a23dc8f2ccc7ad40107"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.8.3/autohand-macos-x64.tar.gz"
      sha256 "6d75260fbe6fb02583802dc0e2fe5980cdc43bc0b044a9ea2de51e8e76f43275"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.8.3/autohand-linux-arm64.tar.gz"
      sha256 "4e5b887a849dc65bd3f18557bdc3e0caa56251f6606b2783a1ec9db444a741cb"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.8.3/autohand-linux-x64.tar.gz"
      sha256 "edde90a38e6103cff78f71a46650c3eda86522b4b482d4315572476a6d3b1f4f"
    end
  end

  def install
    bin.install "autohand" => "autohand-code"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/autohand-code --version")
  end
end
