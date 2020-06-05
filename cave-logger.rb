class CaveLogger < Formula
  homepage "https://github.com/IdlePhysicist/cave-logger"
  desc "A caving database interface written in Go."
  revision 1

  version "1.2.1"
  url "https://github.com/IdlePhysicist/cave-logger/archive/v#{version}.tar.gz"
  sha256 "a0cd5fee2b85f121e0a303124bbf1614ead0cfc7a1da138f5c2ad12f1a86ded2"

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
    system "make", "BUILD=#{bin}", "version=#{version}"
  end

  test do
    system "which","#{bin}/cave-logger"
  end
end
