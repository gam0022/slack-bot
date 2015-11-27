require "slack"
require "pp"

TOKEN = ENV['SLACK_BOT_TOKEN']

Slack.configure do |config|
  config.token = TOKEN
end

client = Slack.realtime

client.on :hello do
  puts 'Successfully connected.'
end

client.on :message do |data|
  pp data

  if data['text'] && data['user'] != "U0FCX6G6L"
    text = nil
    if data['user'] == "U0EVDV0KC"
      text = [
        "なめてんじゃねーぞ（Ｕ＾ω＾）","｜ω･`）ケモナーこわい","｜･ω･`） ひどい…", "オラオラ"
      ].sample
    else
      text = [
        "わんわん（Ｕ＾ω＾）","｜ω･`）チラッ","｜･ω･`） ソー…", 
      ].sample
    end
    Slack.chat_postMessage({
      token: TOKEN,
      channel: data['channel'],
      text: "<@#{data['user']}> #{text}",
      #username: "daigoroubot"
      as_user: true
    })
  end
  #case data['text']
  #when /犬/
  #  Slack.chat_postMessage({
  #    token: TOKEN,
  #    channel: data['channel'],
  #    text: "<@#{data['user']}> わんわん",
  #    #username: "daigoroubot"
  #    as_user: true
  #  })
  #  # Slack.chat_postMessage(text: "aa", channel: 'C0EV8B97Z')
  #when /わんわん/
  #  #client.message channel: data['channel'], text: "未実装"
  #end
end

client.start
