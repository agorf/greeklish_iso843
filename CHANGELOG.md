# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][] and this project adheres to
[Semantic Versioning][].

## [Unreleased][]

### Changed

- Fix transliteration of `ευ` followed by a vowel or `β`, `γ`, `δ`, `ζ`, `λ`,
  `μ`, `ν`, `ρ`. For example, `Ευάγγελος` used to be converted to `Efangelos`
  and now it's `Evangelos`. `άνευ` remains `anef`.
- Use precompiled `Regexp` for replacements to speed things up (#1 @iridakos)

## 0.1.0 - 2021-03-03

Initial release.

[Keep a Changelog]: http://keepachangelog.com/en/1.0.0/
[Semantic Versioning]: http://semver.org/spec/v2.0.0.html
[Unreleased]: https://github.com/agorf/feedigest/compare/0.1.0...HEAD
