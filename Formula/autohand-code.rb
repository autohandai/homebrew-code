class AutohandCode < Formula
  desc "Autonomous LLM-powered coding agent CLI"
  homepage "https://autohand.ai"
  version "0.9.5"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.5/autohand-macos-arm64.tar.gz"
      sha256 "687961227268ac18457988937720c32e72315c68b57af27e929b074ef5b3371b"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.5/autohand-macos-x64.tar.gz"
      sha256 "03540a0eefcff033232436e80ad6ed957f75d5bf736c685bd0564b5090d25c91"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.5/autohand-linux-arm64.tar.gz"
      sha256 "865c1119136682d901b043e3a271661242f2c6911c5fa607a60b00a884e8973f"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.5/autohand-linux-x64.tar.gz"
      sha256 "cda6a8f7e36dc0cc64a841c748a0a513e47b78c3d0d62481e21f9c41eaeba4ac"
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
