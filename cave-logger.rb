class CaveLogger < Formula
  homepage "https://github.com/IdlePhysicist/cave-logger"
  desc "A caving database interface written in Go."
  revision 1

  url "https://github.com/IdlePhysicist/cave-logger/archive/v1.2.tar.gz"
  sha256 "ce3b66a3ac59d92bef1319c716a609884b2fdbeaa2f56214d4e8026344bdad1d"

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
