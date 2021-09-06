class CaveLogger < Formula
  homepage "https://github.com/IdlePhysicist/cave-logger"
  desc "A caving database interface written in Go."
  revision 1

  version "2.0.0-rc3"
  url "https://github.com/IdlePhysicist/cave-logger/archive/v#{version}.tar.gz"
  sha256 "164eda42c30e88e22eab2b032219749f1d569c6244b967b5457a7b613001096b"

  head "https://github.com/IdlePhysicist/cave-logger.git"

  depends_on "go" => :build
  depends_on "python3" => :build


  def install
    bin.mkpath

    # ENV.deparallelize  # if your formula fails when building in parallel
    system "python3", "./scripts/make-db.py"
    if build.head?
      system "make", "BUILD=#{bin}"
    else
      system "make", "BUILD=#{bin}", "version=#{version}"
    end

  end

  test do
    system "which","#{bin}/cave-logger"
    system "#{bin}/cave-logger", "--version"
  end
end
