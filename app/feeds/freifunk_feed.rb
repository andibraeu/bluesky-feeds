require_relative 'feed'

class FreifunkFeed < Feed
  REGEXPS = [
    /freifunk/i, /gluon/i, /\bopenwrt\b/i, /^(?=.*\bbatman\b)(?=.*\brouting\b).*$/i, /^(?=.*\bbabel\b)(?=.*\brouting\b).*$/i, /olsr/i
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
    "freifunk feed"
  end

  def description
    "All posts on Bluesky about free wireless community networks, firmware and routing protocols"
  end

  def avatar_file
    "images/freifunk_logo_gross.png"
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
