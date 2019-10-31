Postgres images with postgis and plv8, built on top of official Postgres images.

### Building an image

```bash
docker build -t "custom_postgres:11.5" \
  --build-arg OFFICIAL_IMAGE_TAG="11.5" \
  --build-arg PLV8_VERSION="2.3.13" \
  --build-arg POSTGIS_VERSION="3" .
```
