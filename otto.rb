class Otto < Formula
  desc "The otto application"
  homepage "https://github.com/kusold/otto"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kusold/otto/releases/download/v0.1.2/otto-aarch64-apple-darwin.tar.xz"
      sha256 "e48d5992b800b8151eb1c1289a6efa1be5272e51e7f32f2056329c7b8b057368"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kusold/otto/releases/download/v0.1.2/otto-x86_64-apple-darwin.tar.xz"
      sha256 "b83181eb758487763994c982f1ede44ad3bff303ed322e23eb37646baaa2de58"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kusold/otto/releases/download/v0.1.2/otto-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "314399c6d58b20aeab663b4f397b44a42aab4b7f57a7310806896b758d3a02f9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kusold/otto/releases/download/v0.1.2/otto-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3bda99cd7d3c88d54c5eeb3e36a209ac7d9e742e129abb8f23ebd2e56bd0c74c"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "otto"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "otto"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "otto"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "otto"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
