## Usage

The SEO tag will respect any of the following if included in your site's `_config.yml` (and simply not include them if they're not defined):

* `title` - Your site's title (e.g., Ben's awesome site, The GitHub Blog, etc.)
* `description` - A short description (e.g., A blog dedicated to reviewing cat gifs)
* `url` - The full URL to your site. Note: `site.github.url` will be used by default.
* `author` - global author information (see below)
* `twitter:username` - The site's Twitter handle. You'll want to describe it like so:

  ```yml
  twitter:
    username: benbalter
  ```

* `facebook` - The following properties are available:
  * `facebook:app_id` - a Facebook app ID for Facebook insights
  * `facebook:publisher` - a Facebook page URL or ID of the publishing entity
  * `facebook:admins` - a Facebook user ID for domain insights linked to a personal account

  You'll want to describe one or more like so:

   ```yml
  facebook:
    app_id: 1234
    publisher: 1234
    admins: 1234
   ```

* `logo` - URL to a site-wide logo (e.g., `/assets/your-company-logo.png`)
* `social` - For [specifying social profiles](https://developers.google.com/structured-data/customize/social-profiles). The following properties are available:
  * `name` - If the user or organization name differs from the site's name
  * `links` - An array of links to social media profiles.
  * `date_modified` - Manually specify the `dateModified` field in the JSON-LD output to override Jekyll's own `dateModified`. This field will take **first priority** for the `dateModified` JSON-LD output. This is useful when the file timestamp does not match the true time that the content was modified. A user may also install [Last Modified At](https://github.com/gjtorikian/jekyll-last-modified-at) which will offer an alternative way of providing for the `dateModified` field.

  ```yml
  social:
    name: Ben Balter
    links:
      - https://twitter.com/BenBalter
      - https://www.facebook.com/ben.balter
      - https://www.linkedin.com/in/BenBalter
      - https://plus.google.com/+BenBalter
      - https://github.com/benbalter
      - https://keybase.io/benbalter
    ```

* `google_site_verification` for verifying ownership via Google webmaster tools
* Alternatively, verify ownership with several services at once using the following format:

```yml
webmaster_verifications:
  google: 1234
  bing: 1234
  alexa: 1234
  yandex: 1234
```

* `lang` - The locale these tags are marked up in. Of the format `language_TERRITORY`. Default is `en_US`.

The SEO tag will respect the following YAML front matter if included in a post, page, or document:

* `title` - The title of the post, page, or document
* `description` - A short description of the page's content
* `image` - URL to an image associated with the post, page, or document (e.g., `/assets/page-pic.jpg`)
* `author` - Page-, post-, or document-specific author information (see below)
* `lang` - Page-, post-, or document-specific language information
