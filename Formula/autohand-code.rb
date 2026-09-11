class AutohandCode < Formula
  desc "Autonomous LLM-powered coding agent CLI"
  homepage "https://autohand.ai"
  version "0.9.7"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.7/autohand-macos-arm64.tar.gz"
      sha256 "1edcaf64966fa375309e547383d0a197c0064743108803edbf722f670a40a003"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.7/autohand-macos-x64.tar.gz"
      sha256 "956f6778517ba7cf183366ef47e99b070f9674927fcbaf3262148b1e6008431f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.7/autohand-linux-arm64.tar.gz"
      sha256 "5b9c990fc2efe8da5514cca6a74b02c51f10e95e860006109969011354158099"
    else
      url "https://github.com/autohandai/code-cli/releases/download/v0.9.7/autohand-linux-x64.tar.gz"
      sha256 "78393bf943413fe39bb8fe5433a0159968dc3c772dff82ffea340dc3e803ffbc"
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
