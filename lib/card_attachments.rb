require 'open-uri'

class CardAttachments

  def initialize(card)
    @card = card
  end

  def card
    @card
  end

  def download_to(path)
    card.attachments.each do |attachment|
      url = attachment.url
      download = open(url)
      local_file = File.join path, download.base_uri.to_s.split('/')[-1]
      IO.copy_stream download, local_file unless File.exists? local_file
    end
  end

  def to_s
    card.attachments.collect do |attachment|
      <<~EOS
        - [#{attachment.name}](#{open(attachment.url).base_uri.to_s.split('/')[-1]})
      EOS
    end.join
  end

end