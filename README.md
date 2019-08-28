# docker-pocketmine-mp

Container with PocketMine MP featuring:

* easy user mappings (PGID, PUID)
* imaged based on s6 overlay

## Usage

### CLI
```
docker create \
    --name=pmmp \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Australia/Melbourne \
    -p 19132/udp:19132/udp \
    -v /path/to/data:/data \
    simojenki/pocketmine-mp
```

### Credits:
 * Inspiration drawn from [circleeh](https://github.com/circleeh/docker-pocketmine/)