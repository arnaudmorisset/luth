# Luth 🪕

Luth a bash script for downloading musics from YouTube videos and push them on a AWS S3 bucket.

## Installation

### On MacOS

```bash
# Install both dependencies.
brew install youtube-dl awscli

# Configure your aws command line, refer to AWS documentation for troubleshooting.
# https://docs.aws.amazon.com/cli/index.html
aws configure

# Set the S3 bucket name as an environnement variable
export LUTH_S3_BUCKET="yourbucketname"
```

### On Linux

```bash
# Install both dependencies.
apt install youtube-dl awscli

# Configure your aws command line, refer to AWS documentation for troubleshooting.
# https://docs.aws.amazon.com/cli/index.html
aws configure

# Set the S3 bucket name as an environnement variable
export LUTH_S3_BUCKET="yourbucketname"
```

## Usage

Fill the `sources` files with all the sounds you want to download from YouTube with a relevant title.

E.g.:

```text
MyAwesomeSound;https://youtu.be/dDDQqK7txvE
```

Then, run the script from the source folder:

```bash
./run.sh

# Can be run with TRACE activated for verbose output. Useful for debugging.
TRACE=1 ./run.sh
```

The script will download each songs asynchronously and push them to S3.
Due to this async nature, no logs will be send to stdout.
Everything is redirected to `logs.txt`.
