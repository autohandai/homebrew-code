class AutohandCode < Formula
  desc "Autonomous LLM-powered coding agent CLI"
  homepage "https://autohand.ai"
  version "0.9.8"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.8/autohand-macos-arm64.tar.gz"
      sha256 "c1511411dda0e1d23c33142e483fb243d3cb59dfe8ab0f9da219ab854a7920b7"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.8/autohand-macos-x64.tar.gz"
      sha256 "69ca6fad6bfa0a5e21db32ce4bd10ddacbc5b3c32d3345da33a6b1b4c36c8efa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.8/autohand-linux-arm64.tar.gz"
      sha256 "7f0d4069dd6f20e3c7dc0431ffc53d97d4750eeb618a6ec0d18c4281c26f4bfe"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.8/autohand-linux-x64.tar.gz"
      sha256 "753ef5bd44953f1b1958b8d54aed4728ceb3318fb4de19ce9e3035b49252168d"
    end
  end

  def install
    bin.install "autohand"
    bin.install "ahtraces"
    bin.install_symlink "autohand" => "autohand-code"
    bin.install_symlink "autohand" => "agent"
    bin.install_symlink "autohand" => "ah"
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
    assert_match version.to_s, shell_output("#{bin}/ahtraces --version")
  end
end
