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

```bash
cd ~/code
git clone git@github.com:fiedl/trello-downloader.git
```

## Author and License

(c) 2017 Sebastian Fiedlschuster

Released under the MIT License.