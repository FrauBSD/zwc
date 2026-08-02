# zwc

`wc(1)` for compressed files — count lines, words, bytes, and characters
without manually piping through `zcat(1)` / friends.

Home: [FrauBSD/zwc](https://github.com/FrauBSD/zwc)

## Why

FreeBSD man pages are stored compressed. Plain `wc(1)` on a `.gz` file counts
the compressed stream, not the document:

```sh
$ wc -l /usr/share/man/man1/wc.1.gz
       9 /usr/share/man/man1/wc.1.gz   # newlines in the gzip stream

$ zwc -l /usr/share/man/man1/wc.1.gz
     213 /usr/share/man/man1/wc.1.gz   # lines in the man page
```

## Install

```sh
make install          # PREFIX=/usr/local by default
make install PREFIX=$HOME
```

Requires `wc(1)`. Decompressors are chosen by suffix and must be on `PATH`
for formats you actually use (`zcat`, `bzcat`, `xzcat`, `zstdcat`, …).

## Usage

```sh
zwc [-c | -m] [-Llw] [file ...]
```

Flags are passed through to `wc(1)`. Compression is detected by suffix:

| Suffix | Decompressor |
|--------|--------------|
| `.Z`, `.gz` | `zcat` |
| `.bz2` | `bzcat` |
| `.lzma` | `lzcat` |
| `.xz` | `xzcat` |
| `.zst`, `.zstd` | `zstdcat` |

Everything else is handed to `wc(1)` as-is.

```sh
zwc -l /usr/share/man/man1/*.1.gz
zwc -L /usr/share/man/man8/daemon.8.gz
zwc -w README.md NOTES.gz archive.xz
```

## See also

`zwc(1)`, `wc(1)`, `zcat(1)`, `bzcat(1)`, `xzcat(1)`, `zstdcat(1)`
