class Therion < Formula
  homepage "https://therion.speleo.sk"
  desc "Therion creates realistic 3D models from 2D maps without quantity of additional information. LRUD dimensions are also supported."
  revision 2

  version "6.2.1"
  url "https://github.com/therion/therion/archive/v#{version}.tar.gz"
  sha256 "70fbb82091b3e8dbb4451604438588bc23c14af8398b1d32676eae019c5f3131"

  head "https://github.com/therion/therion.git"

  depends_on "pkgconfig"
  depends_on "proj"
  depends_on "fmt"
  depends_on "vtk"
  depends_on "wxwidgets"
  depends_on "bwidgets"

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
