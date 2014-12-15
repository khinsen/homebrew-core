require 'formula'

class Bmon < Formula
  homepage 'https://github.com/tgraf/bmon'
  url "https://github.com/tgraf/bmon/releases/download/v3.6/bmon-3.6.tar.gz"
  sha1 "abbe4362061493a1120eed074debd875916dd49a"

  bottle do
    sha1 "403e402182813cc1f63a6b75c2a40db32e328626" => :mavericks
    sha1 "3a5cd94abd456aa3b49cc375ceb72115a4c3a1ad" => :mountain_lion
    sha1 "081de28fe55bf0285c6310fffe8d25ce843b769f" => :lion
  end

  head do
    url "https://github.com/tgraf/bmon.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "confuse" => :build
  depends_on "pkg-config" => :build

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-debug",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make" # two steps to prevent blowing up
    system "make install"
  end

  test do
    system "#{bin}/bmon", "-o", "ascii:quitafter=1"
  end
end
