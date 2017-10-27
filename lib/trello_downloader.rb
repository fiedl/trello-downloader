require_relative 'markdown_card'

class TrelloDownloader
  class << self
    attr_accessor :download_directory

    def download_card(url)
      card_id = url.match(/https:\/\/trello.com\/c\/([^\/]*)\//)[1]
      card = Trello::Card.find(card_id)
      MarkdownCard.new(card).export_to(local_card_file(card))
      #    comments = card.actions({filter: 'commentCard'})
    end

    def local_board_path(board)
      File.join download_directory, sanitize_for_path(board.name)
    end

    def local_card_path(card)
      created_at = card.actions(limit: 1000).last.date
      File.join local_board_path(card.board), "#{created_at.strftime("%Y-%m-%d")} #{sanitize_for_path(card.name)}"
    end

    def local_card_file(card)
      created_at = card.actions(limit: 1000).last.date
      File.join local_board_path(card.board),
          "#{created_at.strftime("%Y-%m-%d")} #{sanitize_for_path(card.name)}",
          "#{created_at.strftime("%Y-%m-%d")} #{sanitize_for_path(card.name)}.md"
    end

    def sanitize_for_path(string)
      string.gsub(":", "").gsub("/", "-")
    end
  end
end