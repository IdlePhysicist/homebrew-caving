class Therion < Formula
  homepage "https://therion.speleo.sk"
  desc "Therion creates realistic 3D models from 2D maps without quantity of additional information. LRUD dimensions are also supported."

  version "6.0.5"
  url "https://github.com/therion/therion/archive/v#{version}.tar.gz"
  sha256 "d9ac96ce7aba5f2614098583116fd40a644e7792f691eb89617911d87e1ec684"

  head "https://github.com/therion/therion.git"

  depends_on "freetype"
  depends_on "imagemagick"
  depends_on "lcdf-typetools"
  depends_on "pkg-config"
  depends_on "proj"
  depends_on "vtk"
  depends_on "wxmac"

  def install
    inreplace "makeinstall.tcl" do |s|
      s.gsub! "/usr/local/bin", bin
      s.gsub! "/usr/local/etc", etc
      s.gsub! "/Applications", prefix
    end

    etc.mkpath
    bin.mkpath

    ENV.prepend_path "PATH", "/Libaray/TeX/texbin"
    ENV.prepend_path "PKG_CONFIG_PATH", "/usr/local/opt/proj/lib/pkgconfig"

    ENV.deparallelize

    # This removes the `doc` build rule, to solve pdftex not found
    system "sed -ie '/^all:/ s/ doc / /g' Makefile"
    system "make", "config-macosx"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/therion", "--version"
  end
end
