TIOCGWINSZ = 0x5413

def terminal_size
  rows = 25
  cols = 80
  buf = [0, 0, 0, 0].pack('SSSS')
  rows, cols, row_pixels, col_pixels = buf.unpack('SSSS') [0..1] if $stdout.ioctl(TIOCGWINSZ, buf) >= 0
  [rows, cols]
end
