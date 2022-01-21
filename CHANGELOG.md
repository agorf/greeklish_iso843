# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][] and this project adheres to
[Semantic Versioning][].

## [Unreleased][]

## [0.4.3][] - 2022-01-21

- Fix `ευς`, `αυς` and `ηυς` throwing `UnhandledCaseError` #3 Thanks @cherouvim

## [0.4.2][] - 2021-05-29

### Changed

- Do not raise `UnhandledCaseError` if next character is a symbol when
  converting a pair that ends with `υ` to `v` or `f`. For example, `άνευ` would
  correctly transliterate to `anef` but `άνευ.` would raise due to `.` at the
  end.
- Fix case for leading `Θ`, `Χ` and `Ψ` when the word is capitalized. For
  example, `ψάθα` would correctly transliterate to `psatha`, but `Ψάθα` would
  incorrectly transliterate to `PSatha`. Now it is transliterated to `Psatha`.

## [0.4.1][] - 2021-04-29

### Changed

- Do not raise `UnhandledCaseError` if next character is whitespace when
  converting a pair that ends with `υ` to `v` or `f`. For example, `άνευ` would
  correctly transliterate to `anef` but `άνευ λόγου` would raise due to the
  whitespace after `ευ`.

## [0.4.0][] - 2021-04-28

### Changed

- Return match as-is if it cannot be handled instead of crashing
- Raise `UnhandledCaseError` in case of an unhandled case when converting pair
  for υ or φ (should never happen)
- Rewrite a significant part of the code to make it more readable

## [0.3.0][] - 2021-03-06

### Changed

- Test text conversion thoroughly with over 100 test cases
- Change API from `GreeklishIso843::Converter.convert(text)` to
  `GreeklishIso843::GreekText.to_greeklish(text)`

## [0.2.0][] - 2021-03-04

### Changed

- Fix transliteration of `ευ` followed by a vowel or `β`, `γ`, `δ`, `ζ`, `λ`,
  `μ`, `ν`, `ρ`. For example, `Ευάγγελος` used to be converted to `Efangelos`
  and now it's `Evangelos`. `άνευ` remains `anef`.
- Use precompiled `Regexp` for replacements to speed things up.
  [#1](https://github.com/agorf/greeklish_iso843/pull/1) by
  [@iridakos](https://github.com/iridakos)

## 0.1.0 - 2021-03-03

Initial release.

[Keep a Changelog]: http://keepachangelog.com/en/1.0.0/
[Semantic Versioning]: http://semver.org/spec/v2.0.0.html
[0.2.0]: https://github.com/agorf/greeklish_iso843/compare/0.1.0...0.2.0
[0.3.0]: https://github.com/agorf/greeklish_iso843/compare/0.2.0...0.3.0
[0.4.0]: https://github.com/agorf/greeklish_iso843/compare/0.3.0...0.4.0
[0.4.1]: https://github.com/agorf/greeklish_iso843/compare/0.4.0...0.4.1
[0.4.2]: https://github.com/agorf/greeklish_iso843/compare/0.4.1...0.4.2
[0.4.3]: https://github.com/agorf/greeklish_iso843/compare/0.4.2...0.4.3
[Unreleased]: https://github.com/agorf/greeklish_iso843/compare/0.4.3...HEAD
