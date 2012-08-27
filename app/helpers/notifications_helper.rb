module NotificationsHelper
  
  def truncate_notification(text, max_sentences = 4, max_words = 40)
    # Take first 2 setences (blah. blah. blah)
    three_sentences = text.split('. ').slice(0, max_sentences).join('. ')
    # Take first 30 words of the above
    shortened = three_sentences.split(' ').slice(0, max_words).join(' ')
    return shortened
  end
  
end