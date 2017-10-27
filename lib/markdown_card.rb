require_relative 'markdown_action'

class MarkdownCard

  def initialize(card)
    @card = card
  end

  def card
    @card
  end

  def export_to(file)
    FileUtils.mkdir_p(File.dirname(file)) unless File.directory?(File.dirname(file))
    File.open(file, 'w') { |file| file.write(self.to_s) }
  end

  def to_s
    <<~EOS
      # #{card.name}

      Url: #{card.url}
      Board: [#{card.board.name}](#{card.board.url})
      List: #{card.list.name}
      Due: #{"✔" if card.due_complete} #{card.due}

      #{card.desc}

      ## Members

      #{card_members}

      ## Attachments

      #{CardAttachments.new(card).to_s}

      ## Comments

      #{card.actions(limit: 1000).collect { |comment| MarkdownAction.new(comment).to_s }.join("\n___\n")}
    EOS
  end

  def card_members
    card.members.collect { |member|
      "- #{member.full_name} (@#{member.username})"
    }.join("\n")
  end

end