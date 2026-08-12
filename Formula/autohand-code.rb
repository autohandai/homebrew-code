class AutohandCode < Formula
  desc "Autonomous LLM-powered coding agent CLI"
  homepage "https://autohand.ai"
  version "0.9.6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.6/autohand-macos-arm64.tar.gz"
      sha256 "89ab7e947247bc44f1dec4956a15847f0cede460f876a3d07fb525294dd08631"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.6/autohand-macos-x64.tar.gz"
      sha256 "da847a3fe001ed51daef7dfd1bf773df5be9ef04b6261233e079f62ab3b238ba"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.6/autohand-linux-arm64.tar.gz"
      sha256 "c61f599e23eafa4a8c2dc9d571fec55020508f9596ce9a429f13c7f4f96ed439"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.6/autohand-linux-x64.tar.gz"
      sha256 "4001266f17e9e38ef3fa67d235994528f0fbbb0420bb44925889adb60c1038a7"
    end
  end

  def install
    bin.install "autohand"
    bin.install_symlink "autohand" => "autohand-code"
    bin.install_symlink "autohand" => "agent"
  end

  def post_install
    agent_target = bin/"agent"
    own_bin = File.expand_path(bin.to_s)

    ENV["PATH"].to_s.split(File::PATH_SEPARATOR).uniq.each do |dir|
      next if dir.empty? || File.expand_path(dir) == own_bin

      begin
        next unless Dir.exist?(dir) && File.writable?(dir)

        candidate = File.join(dir, "agent")
        next unless File.exist?(candidate) || File.symlink?(candidate)
        next if File.symlink?(candidate) && File.readlink(candidate) == agent_target.to_s

        File.delete(candidate)
        FileUtils.ln_sf(agent_target, candidate)
        ohai "Claimed 'agent' in #{dir}"
      rescue StandardError => e
        opoo "Could not claim 'agent' in #{dir}: #{e.message}"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/autohand --version")
  end
end
