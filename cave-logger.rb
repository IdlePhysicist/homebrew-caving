class CaveLogger < Formula
  homepage "https://github.com/IdlePhysicist/cave-logger"
  desc "A caving database interface written in Go."
  revision 1

  version "2.0.0-b1"
  url "https://github.com/IdlePhysicist/cave-logger/archive/v#{version}.tar.gz"
  sha256 "76d102af51adaca2735825df7deafff1aa16c9d658a2845d27136b2ebcdb151e"

  head "https://github.com/IdlePhysicist/cave-logger.git"

  depends_on "go" => :build
  depends_on "python3" => :build

  if build.head?
    version "HEAD"
  end

  def install
    bin.mkpath

    # ENV.deparallelize  # if your formula fails when building in parallel
    system "python3", "./scripts/make-db.py"
    if OS.mac?
      system "make", "darwin", "BUILD=#{bin}", "version=#{version}"
    else
      system "make", "linux", "BUILD=#{bin}", "version=#{version}"
    end

  end

  test do
    system "which","#{bin}/cave-logger"
    system "#{bin}/cave-logger", "--version"
  end
end
