class AutohandCode < Formula
  desc "Autonomous LLM-powered coding agent CLI"
  homepage "https://autohand.ai"
  version "0.9.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.2/autohand-macos-arm64.tar.gz"
      sha256 "67ba95a064d7cc4b8634db1e164f4bd8b31fd98ecf55cee449d4d5c51b644bb0"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.2/autohand-macos-x64.tar.gz"
      sha256 "1312ba4592b73561a47ed7b84c849ffa832c95dfd0ae9c8a2321e3d44371bb97"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.2/autohand-linux-arm64.tar.gz"
      sha256 "3dd9f7adfa4cdcadb571fc0a1a82ef17bc1691334971aa44f8719d0d74da971d"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.2/autohand-linux-x64.tar.gz"
      sha256 "44092e4015416dfaf5b14156587c43a385e4d00a674b300d27cb1e0ca1ad2ea8"
    end
  end

  def install
    bin.install "autohand"
    bin.install_symlink "autohand" => "autohand-code"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/autohand --version")
  end
end
