class CaveLogger < Formula
  homepage "https://github.com/IdlePhysicist/cave-logger"
  desc "A caving database interface written in Go."
  revision 1

  url "https://github.com/IdlePhysicist/cave-logger/archive/v1.1.tar.gz"
  sha256 "e7a7877d54157c0729495260dfb3e4187c51d22d4da2cd8376e74044fc53ab65"
  #version v1.1

  head "https://github.com/IdlePhysicist/cave-logger.git"

  depends_on "go" => :build
  depends_on "python3" => :build

  def install
    bin.mkpath

    # ENV.deparallelize  # if your formula fails when building in parallel
    system "python3", "./scripts/make-db.py"
    system "make", "BUILD=#{bin}"
  end

  test do
    system "which","#{bin}/cave-logger"
  end
end
