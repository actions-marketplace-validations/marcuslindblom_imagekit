# Detects possible savings for faster image loading

Analyzes both desktop and mobile versions of your website and detects possible savings for faster image loading using imagekit.io

A simple example:

```yml
on:
  deployment_status

jobs:
  check:
    name: Detects possible savings for faster image loading
    runs-on: ubuntu-latest
    steps:
      - uses: marcuslindblom/imagekit@main
        with:
          url: ${{ secrets.URL }}
```

