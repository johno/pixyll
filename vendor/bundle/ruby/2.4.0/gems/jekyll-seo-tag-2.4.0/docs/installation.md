# Installing Jekyll SEO Tag

1. Add the following to your site's `Gemfile`:

  ```ruby
  gem 'jekyll-seo-tag'
  ```

2. Add the following to your site's `_config.yml`:

  ```yml
  plugins:
    - jekyll-seo-tag
  ```

3. Add the following right before `</head>` in your site's template(s):

  ```liquid
  {% seo %}
  ```
