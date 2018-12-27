require 'open-uri'
require 'json'

class Timeline < Route
  def resolve
    @access_token = params['access_token']
    actor = fetch(params['account'])
    inbox = fetch(actor['inbox'])
    first_page = fetch(inbox['first'])
    items = first_page['orderedItems']

    items.reject! { |i| i['type'] == 'Delete' && i['actor'] == i['object'] }

    rendered_items =
      items.map do |item|
        <<-ITEM
          <p><strong>#{item['type']}</strong></p>
          <p><em>#{item['actor']}</em></p>
          <pre>#{JSON.pretty_generate(item).gsub('<', '&lt;')}
          </pre>
        ITEM
      end

    finish_html rendered_items.join("\n")
  end

  private

  attr_reader :access_token

  def fetch(uri)
    request =
      open \
        uri,
        'Authorization' => "Bearer #{access_token}",
        'Content-Type' => 'application/activity+json'

    Oj.load(request.read)
  end
end
