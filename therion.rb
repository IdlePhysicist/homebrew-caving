class Therion < Formula
  homepage "https://therion.speleo.sk"
  desc "Therion creates realistic 3D models from 2D maps without quantity of additional information. LRUD dimensions are also supported."

  version "6.2.0"
  url "https://github.com/therion/therion/archive/v#{version}.tar.gz"
  sha256 "8742f77859cbbe122c9b853135543e6a02bcd940dac6aa2f2fac7effc8d0c990"

  head "https://github.com/therion/therion.git"

  depends_on "pkgconfig"
  depends_on "proj"
  depends_on "fmt"
  depends_on "vtk"
  depends_on "wxwidgets"

  def install
    inreplace "makeinstall.tcl" do |s|
      s.gsub! "/usr/local/bin", bin
      s.gsub! "/usr/local/etc", etc
      s.gsub! "/Applications", prefix
    end

    # This sets the correct pkg-config path on M1
    on_arm do
      inreplace "loch/getvtkver.tcl" do |s|
        s.gsub! "searchdirs {/usr /usr/local}", "searchdirs {/opt/homebrew /usr /usr/local}"
      end
    end

    # This removes the `doc` build rule, to solve pdftex not found
    inreplace "Makefile" do |s|
      s.gsub! "tests doc xtherion", "tests xtherion"
    end

    etc.mkpath
    bin.mkpath

    ENV.deparallelize

    system "make", "config-macosx"
    system "make", "./therion"
    system "make", "loch/loch"
    system "make", "install"
  end

  test do
    system "#{bin}/therion", "--version"
  end
end
