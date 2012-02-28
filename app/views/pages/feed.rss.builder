xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Muzkom.com.ua"
    xml.description "Интернет магазин оборудование для: DJ‘s, саунд-продюсеров, музыкантов, ночных клубов"
    xml.link publications_url

    for post in @publications
      xml.item do
        xml.title post.title
        xml.description post.lead
        xml.pubDate post.date.to_s(:rfc822)
        xml.link publication_url(post)
        xml.guid publication_url(post)
      end
    end
  end
end