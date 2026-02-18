# https://docs.getpelican.com/en/latest/settings.html

SITENAME = 'DevSensation'
SITEURL = 'https://avisiedo.github.io/blog'

PATH = 'content'
STATIC_PATHS = ['static', 'images', 'favicon.ico']

TIMEZONE = 'Europe/Madrid'

DEFAULT_LANG = 'en'

PLUGIN_PATHS = ['plugins']
PLUGINS = ['seo', 'readtime', 'plantuml']

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Blogroll
LINKS = (('Pelican', 'https://getpelican.com/'),
         ('Python.org', 'https://www.python.org/'),
         ('Jinja2', 'https://palletsprojects.com/p/jinja/'),
        )

# Social widget
SOCIAL = (
  ('github', 'https://github.com/avisiedo'),
  ('envelope','mailto:alejandro.visiedo+spam@gmail.com'),
)
SHOW_SOCIAL_ON_INDEX_PAGE_HEADER = True

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
RELATIVE_URLS = True

# https://github.com/gilsondev/pelican-clean-blog/tree/master?tab=readme-ov-file
THEME = './templates/blog-theme'

# Template specific
# https://github.com/gilsondev/pelican-clean-blog/tree/master?tab=readme-ov-file#basic-configuration
HEADER_COVER = 'static/header-cover.jpg'
COLOR_SCHEME_CSS = 'monokai.css'
FAVICON = 'favicon.ico'
