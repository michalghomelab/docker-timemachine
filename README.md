# Docker TimeMachine
### Creates a Docker container for running the Time Machine compatible backup service.
Based on my bare metal TimeMachine install and [willtho89's](https://github.com/willtho89) [script files](https://github.com/willtho89/docker-samba-timemachine)

[![Release](https://github.com/michalg-/docker-timemachine/actions/workflows/release.yml/badge.svg)](https://github.com/michalg-/docker-timemachine/actions/workflows/release.yml)
[![License](https://img.shields.io/github/license/michalg-/docker-timemachine)](https://github.com/michalg-/docker-timemachine/blob/master/LICENSE)

### Image

```sh
docker pull ghcr.io/michalg-/docker-timemachine:latest
```

### Environment Variables
| Variable  | Function                | Default.    |
| ----------|:-----------------------:|-------------:|
| TM_USER   | Time Machine User       | timemachine |
| TM_PW     | User's Password         | timemachine |
| TM_ID     | UserID                  | 1000        |
| TM_SIZE   | Time Machine Size in GB | 250         |

### Releasing

Push a semver tag to build and publish a multi-arch image to GitHub Container Registry and create a GitHub release:

```sh
git tag v1.0.0
git push origin v1.0.0
```
