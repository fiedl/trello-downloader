require_relative 'markdown_card'
require_relative 'card_attachments'

class TrelloDownloader
  class << self
    attr_accessor :download_directory

    def download_card(url)
      card_id = url.match(/https:\/\/trello.com\/c\/([^\/]*)\//)[1]
      card = Trello::Card.find(card_id)
      MarkdownCard.new(card).export_to(local_card_file(card))
      CardAttachments.new(card).download_to(local_card_path(card))
    end

    def local_board_path(board)
      File.join download_directory, sanitize_for_path(board.name)
    end

    def local_card_path(card)
      File.join local_board_path(card.board), "#{card.created_at.strftime("%Y-%m-%d")} #{sanitize_for_path(card.name)}"
    end

    def local_card_file(card)
      File.join local_board_path(card.board),
          "#{card.created_at.strftime("%Y-%m-%d")} #{sanitize_for_path(card.name)}",
          "#{card.created_at.strftime("%Y-%m-%d")} #{sanitize_for_path(card.name)}.md"
    end

    def sanitize_for_path(string)
      string.gsub(":", "").gsub("/", "-")
    end
  end
end