class Timespan < Formula
  desc "Local time tracking application built with Rust"
  homepage "https://github.com/hisgarden/TimeSpan"
  url "https://github.com/hisgarden/TimeSpan/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "799cb06fb51e388c646e9048a4cb6f2071dab48d3656eaf081bdfac5b1859fbf"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # Test that the binary was installed and can run
    assert_match "A local time tracking application", shell_output("#{bin}/timespan --help")

    # Test basic functionality with temporary database
    system "#{bin}/timespan", "--database", "#{testpath}/test.db", "project", "create", "Test Project"
    assert_match "Test Project", shell_output("#{bin}/timespan --database #{testpath}/test.db project list")

    # Test status (should show no active timer)
    assert_match "No active timer", shell_output("#{bin}/timespan --database #{testpath}/test.db status")
  end
end
