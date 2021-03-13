class CaveLogger < Formula
  homepage "https://github.com/IdlePhysicist/cave-logger"
  desc "A caving database interface written in Go."
  revision 1

  version "v2.0.0-rc1"
  url "https://github.com/IdlePhysicist/cave-logger/archive/#{version}.tar.gz"
  sha256 "5b95e03dcc44ef91b8fbcc9da6c8c74610dd639ce1a9a2e41086c02972193913"

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
