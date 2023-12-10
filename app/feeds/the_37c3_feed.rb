require_relative 'feed'

class The37c3Feed < Feed
  REGEXPS = [
    /37c3/i, /37th chaos communication congress/i, /ccc congress/i, /^(?=.*\37\.\b)(?=.*chaos communication congress).*$/i, /^(?=.*\b37c3\b)(?=.*\bcch\b).*$/i, /chaos congress/i
  ]

  EXCLUDE = [
  ]

  MUTED_PROFILES = [
    # 'did:plc:35c6qworuvguvwnpjwfq3b5p',  # Linux Kernel Releases
  ]

  def feed_id
    1
  end

  def display_name
    "37c3 feed"
  end

  def description
    "First feed for 37c3 posts, for improvements: contributions are welcome at https://github.com/andibraeu/bluesky-freifunk-feed"
  end

  def avatar_file
    "images/37c3-logo-full-black.png"
  end

  def post_matches?(post)
    return false if MUTED_PROFILES.include?(post.repo)

    REGEXPS.any? { |r| post.text =~ r } && !(EXCLUDE.any? { |r| post.text =~ r })
  end

  def colored_text(t)
    text = t.dup

    EXCLUDE.each { |r| text.gsub!(r) { |s| Rainbow(s).red }}
    REGEXPS.each { |r| text.gsub!(r) { |s| Rainbow(s).green }}

    text
  end
end
