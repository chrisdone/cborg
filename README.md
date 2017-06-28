# Fast CBOR implementation for Haskell

[![Linux Build Status](https://img.shields.io/travis/well-typed/cborg/master.svg?label=Linux%20build)](https://travis-ci.org/well-typed/cborg)
[![Windows Build Status](https://img.shields.io/appveyor/ci/thoughtpolice/cborg/master.svg?label=Windows%20build)](https://ci.appveyor.com/project/thoughtpolice/cborg/branch/master)
[![Hackage version](https://img.shields.io/hackage/v/cborg.svg?label=Hackage)](https://hackage.haskell.org/package/cborg)
[![Stackage version](https://www.stackage.org/package/cborg/badge/lts?label=Stackage)](https://www.stackage.org/package/cborg)
[![BSD3](https://img.shields.io/badge/License-BSD-blue.svg)](https://en.wikipedia.org/wiki/BSD_License)
[![Haskell](https://img.shields.io/badge/Language-Haskell-yellowgreen.svg)](https://www.haskell.org)

**NOTE**: Currently this library has not been released to the public Hackage
server, as the API is still considered to be in flux -- while the on-disk
formats should remain stable. Despite that, the code has seen _substantial_
production use by Well-Typed, as well as a number of outsiders and independent
companies. We've had near-universal positive results with it, so you should
feel relatively safe in experimenting.

---

This package provides a fast, standards-compliant implementation of the 'Concise
Binary Object Representation' (specified in `RFC 7049`) for Haskell. It serves
as the foundation for the `serialise` library, a serialisation library for
Haskell.

# Installation

It's just a `cabal install` away on [Hackage][], or through [Stackage][]:

```bash
$ cabal install cborg
$ stack install cborg
```

**NOTE**: The above currently **WILL NOT WORK**, as this package is not
publicly released.

[Hackage]:  https://hackage.haskell.org/package/cborg
[Stackage]: https://www.stackage.org

# Join in

Be sure to read the [contributing guidelines][contribute]. File bugs
in the GitHub [issue tracker][].

Master [git repository][gh]:

* `git clone https://github.com/well-typed/cborg.git`

The tests for this package are included in the `serialise` package.

```bash
$ cabal test serialise
$ stack test serialise
```

Note: the `stack.yaml` file is currently synchronized to **LTS-8.13**. Further
compilers and other LTS releases are currently not supported with Stack at the
moment, but the build *is* tested with older compilers and Cabal libraries
(through Travis CI).

[contribute]: https://github.com/well-typed/cborg/blob/master/.github/CONTRIBUTING.md
[issue tracker]: http://github.com/well-typed/cborg/issues
[gh]: http://github.com/well-typed/cborg

# Authors

See
[AUTHORS.txt](https://raw.github.com/well-typed/cborg/master/AUTHORS.txt).

# License

BSD3. See
[LICENSE.txt](https://raw.github.com/well-typed/cborg/master/LICENSE.txt)
for the exact terms of copyright and redistribution.
