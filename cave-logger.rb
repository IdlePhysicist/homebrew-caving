class CaveLogger < Formula
  homepage "https://github.com/IdlePhysicist/cave-logger"
  desc "A caving database interface written in Go."
  revision 1

  version "1.2.2"
  url "https://github.com/IdlePhysicist/cave-logger/archive/v#{version}.tar.gz"
  sha256 "8e9ed8f898efd440a0532859717e8619b98c4a8cf96a9a4058820441b457f370"

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
