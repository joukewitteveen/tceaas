# Rudimentary package manager for systems with a volatile filesystem

Systems with a volatile root filesystem, for example a read-only mounted
root filesystem with a tmpfs overlay on top, are not served well by common
package management solutions. With such package managers, packages are
typically archives that are extracted to the target filesystem. When
that target filesystem is kept in memory, this is wasteful. An elegant
solution exists in the form of Tiny Core Extensions. These extensions are
mounted instead of extracted, with symlinks pointing from the intended
paths into the mounted extensions.

The runtime management of Tiny Core Extensions maps well to systemd
services. While the implementation provided by tceaas (Tiny Core Extensions
as a service) aims to be compatible with existing extensions, no provisions
are made for automatic fetching of packages.


## Loading & unloading

Loading an extension that provides an application of interest, say
`APP.tcz`, is done as follows.
```sh
systemctl start \
  "$(systemd-escape --template=tceaas@.service --path "/PATH/TO/APP.tcz")"
```

Unloading is done similarly, but using `stop` instead of `start`.

Dependency resolution is not possible automatically, but can be achieved
through drop-in configurations for specialized systemd units using
primitives like `Requires=`.


## Creating packages

A Tiny Core Extension is nothing more than a snapshot of the stagin
directory in a staged install. One can be created similar to the following.
```sh
make DESTDIR=stage install
mksquashfs stage APP.tcz -all-root -no-xattrs
```
