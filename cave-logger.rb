class CaveLogger < Formula
  homepage "https://github.com/IdlePhysicist/cave-logger"
  desc "A caving database interface written in Go."
  revision 1

  version "2.0.2"
  url "https://github.com/IdlePhysicist/cave-logger/archive/v#{version}.tar.gz"
  sha256 "165515e4436d1db035a98f1ada7a1fb8800779fc62bba6b216292b4121447456"

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
