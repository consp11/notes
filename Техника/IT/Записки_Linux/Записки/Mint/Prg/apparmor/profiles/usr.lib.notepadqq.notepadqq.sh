# Last Modified: Thu May 18 09:01:09 2023
abi <abi/3.0>,

include <tunables/global>

/usr/lib/notepadqq/notepadqq.sh {
  include <abstractions/base>
  include <abstractions/bash>

  /etc/ld.so.cache r,
  /etc/ld.so.preload r,
  /usr/bin/dash r,
  /usr/bin/dirname mrix,
  /usr/bin/readlink mrix,
  /usr/lib/notepadqq/notepadqq-bin mrpx,

}
