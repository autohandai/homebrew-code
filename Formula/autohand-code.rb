class AutohandCode < Formula
  desc "Autonomous LLM-powered coding agent CLI"
  homepage "https://autohand.ai"
  version "0.9.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.0/autohand-macos-arm64.tar.gz"
      sha256 "0dbbb7b5ff6204704b889f82701eea1c43489988427b1a8d729b3f3f71833784"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.0/autohand-macos-x64.tar.gz"
      sha256 "dd45cde9c2045627e3fd6937c2001f35ab9bf3833c801fd60a7f912f750f6f4e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.0/autohand-linux-arm64.tar.gz"
      sha256 "639f28f3e60ca79759e5b7bf668df43687e05005e3300eb172f29153aba4cfe3"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.0/autohand-linux-x64.tar.gz"
      sha256 "c57fc1a2474779af0cdf3aef8c2b02b30a82b9e23ce97e72b5c65d31d2200e04"
    end
  end

  def install
    bin.install "autohand" => "autohand-code"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/autohand-code --version")
  end
end
