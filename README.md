### fpm-redis

Creates a redis RPM and .deb packages using masterless puppet modules

## Limitations

  The script only runs on RHEL based systems (sorry ubuntu and mac users)

## Usage

- Edit variables in redis-rhel.sh


    export FACTER_FPM_REDIS_PORT="6390"
    export FACTER_FPM_REDIS_VERSION="2.8.8"
    export FACTER_FPM_EMAIL='sowen@adaptivecomputing.com'
    export FACTER_FPM_ITTERATION="1"

- Run script

    ./redis-rhel.sh

- .deb and .rpm files will magically appear in the working directory
- Enjoy


## Roadmap

- Convert into docker box to provide cross platform usability

## Contact

twitter => @spencer450
github  => spuder

