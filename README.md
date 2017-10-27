# TrelloDownloader

Command line tool that downloads trello cards or boards and stores them locally as markdown files together with the card attachments. This is helpful for archiving boards locally in a readable format.

## Usage

```bash
cd trello-downloader
bin/trello-download [options] [url(s)]

# Download a single card
bin/trello-download https://trello.com/c/rpkUdV9H/179-my-test-card
```

This will create:

```
~/Downloads
     |--- [Trello Board Name]
                 |-------- [yyyy-mm-dd Trello Card Name]
                                        |---- [yyyy-mm-dd Trello Card Name].md
                                        |---- [Attachment 1]
                                        |---- [Attachment 2]
```

## Installation

This tool requires [ruby](https://www.ruby-lang.org).

```bash
cd ~/code
git clone git@github.com:fiedl/trello-downloader.git

cd trello-downloader
bundle install
```

Create an API key pair and store it in environment variables, e.g. in `~/.zshenv`:

```bash
# ~/.zshenv

# Trello Downloader
export TRELLO_DOWNLOADER_DEVELOPER_PUBLIC_KEY=...
export TRELLO_DOWNLOADER_MEMBER_TOKEN=...
```

A simple way to create those, is using the [ruby-trello api client](https://github.com/jeremytregunna/ruby-trello):

```bash
$ gem install ruby-trello
$ irb -rubygems
irb> require 'trello'
irb> Trello.open_public_key_url                         # copy your public key
irb> Trello.open_authorization_url key: 'yourpublickey' # copy your member token
```



## Author and License

(c) 2017 Sebastian Fiedlschuster

Released under the MIT License.