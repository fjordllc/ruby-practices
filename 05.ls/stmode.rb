# frozen_string_literal:true

# about STMODE
module StMode
  S_IXOTH = (1 << 0) # 0001 Execute or search permission bit for other users. Usually 01.
  S_IWOTH = (1 << 1) # 0002 Write permission bit for other users. Usually 02.
  S_IROTH = (1 << 2) # 0004 Read permission bit for other users. Usually 04.
  S_IRWXO = (S_IXOTH | S_IWOTH | S_IROTH) # 007 This is equivalent to (S_IROTH | S_IWOTH | S_IXOTH).
  S_IXGRP = (1 << 3) # 00010	Execute or search permission bit for the group owner of the file. Usually 010.
  S_IWGRP = (1 << 4) # 00020	Write permission bit for the group owner of the file. Usually 020.
  S_IRGRP = (1 << 5) # 00040	Read permission bit for the group owner of the file. Usually 040.
  S_IRWXG = (S_IXGRP | S_IWGRP | S_IRGRP) # 00070	This is equivalent to (S_IRUSR | S_IWUSR | S_IXUSR).
  S_IXUSR = (1 << 6) # 00100  Execute or search permission bit for the owner of the file. Usually 0100.
  S_IWUSR = (1 << 7) # 00200  Write permission bit for the owner of the file. Usually 0200.
  S_IRUSR = (1 << 8) # 00400  Read permission bit for the owner of the file. On many systems this bit is 0400.
  S_IRWXU = (S_IXUSR | S_IWUSR | S_IRUSR) # 00700	This is equivalent to (S_IRUSR | S_IWUSR | S_IXUSR).

  S_ISVTX = (1 << 9)  # 01000 This is the sticky bit, usually 01000.
  S_ISGID = (1 << 10) # 02000 This is the set-group-ID on execute bit, usually 02000.
  S_ISUID = (1 << 11) # 04000 This is the set-user-ID on execute bit, usually 04000.

  S_IFIFO = (1 << 12)   # 0010000	This is the file type constant of a FIFO or pipe.
  S_IFCHR = (1 << 13)   # 0020000	This is the file type constant of a character-oriented device file.
  S_IFDIR = (1 << 14)   # 0040000	This is the file type constant of a directory file.
  S_IFBLK = (S_IFCHR | S_IFDIR) # 0060000	This is the file type constant of a block-oriented device file.
  S_IFREG = (1 << 15) # 0100000	This is the file type constant of a regular file.
  S_IFLNK = (S_IFREG | S_IFCHR) # 0120000	This is the file type constant of a symbolic link.
  S_IFSOCK = (S_IFREG | S_IFDIR) # 0140000	This is the file type constant of a socket.
  S_IFWHT  = (S_IFREG | S_IFBLK)
  S_IFMT = (S_IFIFO | S_IFCHR | S_IFDIR | S_IFREG)	# 0170000

  def strmode(mode)
    # print type
    ret = ''
    ret +=
      { S_IFDIR => 'd', # directory
        S_IFCHR => 'c', # character special
        S_IFBLK => 'b', # block special
        S_IFREG => '-', # regular
        S_IFLNK => 'l', # symbolic link
        S_IFSOCK => 's', # socket
        S_IFIFO => 'p', # fifo
        S_IFWHT => 'w' }[mode & S_IFMT] || '?' # whiteout

    # usr
    ret += (mode & S_IRUSR) == S_IRUSR ? 'r' : '-'

    ret += (mode & S_IWUSR) == S_IWUSR ? 'w' : '-'

    ret += {
      0 => '-',
      S_IXUSR => 'x',
      S_ISUID => 'S',
      S_IXUSR | S_ISUID => 's'
    }[mode & (S_IXUSR | S_ISUID)]

    # group
    ret += (mode & S_IRGRP) == S_IRGRP ? 'r' : '-'
    ret += (mode & S_IWGRP) == S_IWGRP ? 'w' : '-'
    ret += { 0 => '-',
             S_IXGRP => 'x',
             S_ISGID => 'S',
             S_IXGRP | S_ISGID => 's' }[mode & (S_IXGRP | S_ISGID)]
    # other
    ret += (mode & S_IROTH) == S_IROTH ? 'r' : '-'
    ret += (mode & S_IWOTH) == S_IWOTH ? 'w' : '-'
    ret += { 0 => '-',
             S_IXOTH => 'x',
             S_ISVTX => 'T',
             S_IXOTH | S_ISVTX => 't' }[mode & (S_IXOTH | S_ISVTX)]

    ret
  end
end
