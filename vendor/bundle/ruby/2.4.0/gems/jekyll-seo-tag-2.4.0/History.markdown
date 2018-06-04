## HEAD

## 2.4.0 / 2017-12-04

### Minor

  * Add meta generator (#236)
  * Consistently use self-closing tags (#246)
  * Strip null values from JSON-LD hash (#249)

### Documentation

  * Avoid deprecation warning when building docs (#243)

### Development Fixes

  * Test against latest Rubies (#242)
  * Use Nokigiri on CI (#181)

## 2.3.0

### Minor Enhancements

  * Use canonical_url specified in page if present #211
  * Fix for image.path causing an invalid url error #228
  * Ensure `site.data.authors` is properly formatted before attempting to retrieve author meta #227
  * Convert author, image, and JSON-LD to dedicated drops #229
  * Cache parsed template #231
  * Define path with `__dir__` #232

### Documentation

  * gems: is deprecated in current Jekyll version of github-pages #230

## 2.2.3

  * Guard against the author's Twitter handle being Nil when stripping @'s #203
  * Guard against empty title or description strings #206

## 2.2.2

### Minor Enhancements

  * Guard against arrays in subhashes #197
  * Guard against invalid or missing URLs #199

### Development fixes

  * Remove dynamic GitHub Pages logic from Gemfile #194

## 2.2.1

  * Convert template logic to a Liquid Drop (significant performance improvement) (#184)
  * Fix for JSON-LD validation warning for images missing required properties (#183)

## 2.2.0

### Major Enhancements

  * Add author meta (#103)
  * Add og:locale support #166
  * Add support for Bing and Yandex webmaster tools. Closes #147 (#148)
  * Add SEO author and date modified to validate JSON-LD output (#151)

### Minor Enhancements

  * Use `|` for title separator (#162)
  * Use `og:image` for twitter image (#174)

### Development Fixes

  * Style fixes (#170, #157, #149)
  * Test against latest version of Jekyll (#171)
  * Bump dev dependencies (#172)
  * Remove Rake dependency (#180)

## 2.1.0

### Major Enhancement

  * Use new URL filters (#123)

### Minor Enhancements

  * Wraps logo image json data in a publisher property (#133)
  * Fix duplicated `escape_once` (#93)
  * Simplify minify regex (#125)
  * Don't mangle text with newlines #126

### Documentation

  * Add front matter default example for image (#132)
  * Fix tiny typo (#106)
  * add example usage of social profiles (#139)

### Development

  * Inherit Jekyll's rubocop config for consistency (#109)
  * Correct spelling in .travis.yml (#112)
