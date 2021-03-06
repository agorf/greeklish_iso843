# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][] and this project adheres to
[Semantic Versioning][].

## [Unreleased][]

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
[Unreleased]: https://github.com/agorf/greeklish_iso843/compare/0.2.0...HEAD
