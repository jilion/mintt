## Development

1. Install the dependencies: `bundle install`
2. Start the dev server: `bundle exec rackup`
3. Visit http://localhost:3000 (http://localhost:3000/admin for the admin)

## Prepare the site for a new year

### Add the course's date in `config/site_settings.yml`

Add a new section in `config/site_settings.yml` under `defaults.course_dates` for the new year, e.g.:

```yaml
defaults: &defaults
  ...
  course_dates:
    ... previous years ...
    year_2014:
      day_1:
        - 2014-06-04
        - 2014-06-06
      day_2:
        - 2014-06-05
        - 2014-06-07
      day_3:
        - 2014-10-08
        - 2014-10-09
```

### Open the applications

Change `applications_open: false` to `applications_open: true` in `config/site_settings.yml`.

The application form (`/apply`) should now be accessible.

## Production

### Deployment

```shell
$> cap deploy
```

You can access the website at https://mintt.epfl.ch

**If something is not good, simply rollback:**

```shell
$> cap deploy:rollback
```

### Admin

You can access the admin at https://mintt.epfl.ch/admin, credentials can be found in `config/admin.yml`.
