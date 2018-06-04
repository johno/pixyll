1.9.25 / 2018-06-03
-------------------

Changed:
* Revert closures via libffi.
  This re-adds ClosurePool and fixes compat with SELinux enabled systems. #621


1.9.24 / 2018-06-02
-------------------

Added:
* Added a CHANGELOG file
* Add mips64(eb) support, and mips r6 support. (#601)

Changed:
* Update libffi to latest changes on master.
* Don't search in hardcoded /usr paths on Windows.
* Don't treat Symbol args different to Strings in ffi_lib.
* Make sure size_t is defined in Thread.c. Fixes #609


1.9.23 / 2018-02-25
-------------------

Changed:
* Fix unnecessary rebuild of configure in darwin multi arch. Fixes #605


1.9.22 / 2018-02-22
-------------------

Changed:
* Update libffi to latest changes on master.
* Update detection of system libffi to match new requirements. Fixes #617
* Prefer bundled libffi over system libffi on Mac OS.
* Do closures via libffi. This removes ClosurePool and fixes compat with PaX. #540
* Use a more deterministic gem packaging.
* Fix unnecessary update of autoconf files at gem install.


1.9.21 / 2018-02-06
-------------------

Added:
* Ruby-2.5 support by Windows binary gems. Fixes #598
* Add missing win64 types.
* Added support for Bitmask. (#573)
* Add support for MSYS2 (#572) and Sparc64 Linux. (#574)

Changed:
* Fix read_string to not throw an error on length 0.
* Don't use absolute paths for sh and env. Fixes usage on Adroid #528
* Use Ruby implementation for `which` for better compat with Windows. Fixes #315
* Fix compatibility with PPC64LE platform. (#577)
* Normalize sparc64 to sparcv9. (#575)

Removed:
* Drop Ruby 1.8.7 support (#480)


1.9.18 / 2017-03-03
-------------------

Added:
* Add compatibility with Ruby-2.4.

Changed:
* Add missing shlwapi.h include to fix Windows build.
* Avoid undefined behaviour of LoadLibrary() on Windows. #553


1.9.17 / 2017-01-13
-------------------
