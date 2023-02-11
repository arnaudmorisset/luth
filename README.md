# Luth 🪕

Luth is a bash script for downloading musics from YouTube and push them on a AWS S3 bucket.

## Installation

### On MacOS

```bash
# Install both dependencies.
brew install youtube-dl awscli

# Configure your AWS CLI, refer to AWS documentation for troubleshooting.
# https://docs.aws.amazon.com/cli/index.html
aws configure

# Set the S3 bucket name as an environnement variable
export LUTH_S3_BUCKET="yourbucketname"
```

### On Linux

```bash
# Install both dependencies.
apt install youtube-dl awscli

# Configure your AWS CLI, refer to AWS documentation for troubleshooting.
# https://docs.aws.amazon.com/cli/index.html
aws configure

# Set the S3 bucket name as an environnement variable
export LUTH_S3_BUCKET="yourbucketname"
```

## Usage

Fill the `sources` files with all the sounds you want to download from YouTube, with a relevant title.

Here's the format: `[title];[url]`

E.g.:

```text
MyAwesomeSound;https://youtu.be/dDDQqK7txvE
AnotherOne;https://youtu.be/dDDQqK7txvE
```

Then, run the script from the source folder:

```bash
./run.sh

# Can be ran with TRACE activated for verbose output. Useful for debugging.
TRACE=1 ./run.sh
```

The script will download each songs asynchronously and push them to S3.
Due to this async nature, no logs will be send to _stdout_.
Everything is redirected to `logs.txt`.
