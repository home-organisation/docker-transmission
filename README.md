# docker-transmission
This docker image is a custom image of prowlarr based on lscr.io/linuxserver/transmission.

# Parameters
Container images are configured using parameters passed at runtime has environment variable.

The parameters below are taken from the original image [lscr.io/linuxserver/transmission](https://hub.docker.com/r/linuxserver/transmission) :
|  Parameters | Examples values  | Functions                                                                                                      |
|-------------|------------------|----------------------------------------------------------------------------------------------------------------|
| PUID        |  1000            | for UserID                                                                                                     |
| PGID        |  1000            | for GroupID                                                                                                    |
| TZ          |  Europe/Paris    | Specify a timezone to use, see this [List](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List). |
| USER        |  admin           | Admin user                                                                                                     |
| PASS        |  ****            | Admin password                                                                                                 |


The extra parameters below come from this custom image :
|  Parameters           | Examples values   | Functions                                                               |
|-----------------------|-------------------|-------------------------------------------------------------------------|
| DOWNLOAD_TVCATEGORY   |  tvshows          | Subdirectory to create under "/downloads" to separate Sonarr downloads  |
| DOWNLOAD_FILMCATEGORY |  films            | Subdirectory to create under "/downloads" to separate Radarr downloads  |

Some parameter is set statically in custom script :
* Enable blocklist-url with "https://mirror.codebucket.de/transmission/blocklist.p2p.gz"
* Set download-dir to "/downloads/"
* Disable dht, pex and incomplete-dir
