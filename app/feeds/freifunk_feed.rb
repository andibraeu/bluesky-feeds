require_relative 'feed'

class FreifunkFeed < Feed
  REGEXPS = [
    /freifunk/i, /^(?=.*\bgluon\b)(?=.*\brouting\b).*$/i, /^(?=.*\bgluon\b)(?=.*\bfreifunk\b).*$/i, /^(?=.*\bgluon\b)(?=.*\bopenwrt\b).*$/i, /\bopenwrt\b/i, /^(?=.*\bbatman\b)(?=.*\brouting\b).*$/i, /^(?=.*\bbabel\b)(?=.*\brouting\b).*$/i, /\bolsr\b/i
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
    "Freifunk"
  end

  def description
    "All posts on Bluesky about freifunk, free wireless community networks, firmware and routing protocols, for improvements: contributions are welcome at https://github.com/andibraeu/bluesky-feeds"
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
