class MarkdownAction

  def initialize(action)
    @action = action
  end

  def action
    @action
  end

  def to_s
    <<~EOS
      #{action.member_creator.full_name} | #{action.date} | #{action.type}

      #{action_text}
    EOS
  end

  def action_text
    case action.type
    when 'commentCard'
      action.data['text']
    when 'updateCheckItemStateOnCard'
      title = "#{action.data['checklist']['name']}: #{action.data['checkItem']['name']}"
      if action.data['checkItem']['state'] == 'complete'
        "✔ #{title}"
      else
        "✘ #{title}"
      end
    when 'updateCard'
      if action.data['listAfter']
        "#{action.data['listBefore']['name']} → #{action.data['listAfter']['name']}"
      else
        "    #{action.data}"
      end
    when 'addAttachmentToCard'
      "📎 #{action.data['attachment']['name']}" + if action.data['attachment']['mimeType'].include?('image')
        "\n\n![image](#{open(action.data['attachment']['url']).base_uri.to_s.split('/')[-1]})"
      end
    when 'deleteAttachmentFromCard'
      "✘ #{action.data['attachment']['name']}"
    else
      "    #{action.data}"
    end
  end

end