class AutohandCode < Formula
  desc "Autonomous LLM-powered coding agent CLI"
  homepage "https://autohand.ai"
  version "0.9.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.3/autohand-macos-arm64.tar.gz"
      sha256 "0981695eb110484d360c35f145b996b439db6f81e7cc6a25958f2fb6c76f7da6"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.3/autohand-macos-x64.tar.gz"
      sha256 "b0d2191bf4bfb0f6644c76071045e06745a3fb1bea0a674052d2ffab651d8139"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.3/autohand-linux-arm64.tar.gz"
      sha256 "e4e151f250a2b90971a6f545cfcaa03c602e1bbddb76fcda73722e702508949e"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.3/autohand-linux-x64.tar.gz"
      sha256 "afe1886d364c6ef2aa80fd521512c86554a4ef23074b980fe5999d16efc5c5f2"
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
