# greeklish_iso843 ![Gem](https://img.shields.io/gem/v/greeklish_iso843?color=blue) ![CI](https://github.com/agorf/greeklish_iso843/actions/workflows/ci.yml/badge.svg)

A [Ruby][] library that converts Greek text to [Greeklish][], conforming to the
[ISO 843][] (ELOT 743) standard used by the Greek State.

[Ruby]: https://www.ruby-lang.org/en/
[Greeklish]: https://en.wikipedia.org/wiki/Greeklish
[ISO 843]: https://www.iso.org/standard/5215.html

## Installation

As a [Gem][]:

```sh
gem install greeklish_iso843
```

[Gem]: https://rubygems.org/gems/greeklish_iso843/

## Use

Require the library in your code:

```ruby
require 'greeklish_iso843'
```

Then you can use it to convert text:

```ruby
GreeklishIso843::Converter.convert("Μπάμπης") # => "Bampis"
GreeklishIso843::Converter.convert("Άγγελος") # => "Angelos"
GreeklishIso843::Converter.convert("Ευάγγελος") # => "Evangelos"
GreeklishIso843::Converter.convert("άνευ αποδοχών") # => "anef apodochon"
```

Alternatively, you can require the `String` core extension for more convenience:

```ruby
require 'greeklish_iso843/core_ext/string'
```

Then you can use it to convert text:

```ruby
"Μπάμπης".to_greeklish # => "Bampis"
```

There's also a command line utility that accepts Greek text from the standard
input and prints the corresponding Greeklish text to the standard output:

```sh
$ greeklish_iso843
Μπάμπης
^D
Bampis
$
```

Note: `^D` represents the EOF (End Of File) character, emitted with `Ctrl-D`.

## Acknowledgements

This library was based on [an official implementation in JavaScript][js].

[js]: http://www.passport.gov.gr/passports/GrElotConverter/GrElotConverter.html

## License

[MIT](https://github.com/agorf/greeklish_iso843/blob/master/LICENSE.txt)

## Author

[Angelos Orfanakos](https://angelos.dev/)
