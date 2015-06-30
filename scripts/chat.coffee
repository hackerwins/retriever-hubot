slack = require './slack.coffee'

module.exports = (robot) ->
  robot.hear /!두둠칫/i, (msg) -> 
    msg.send """
⊂_ヽ
　 ＼＼ Λ＿Λ 
　　 ＼( ‘ㅅ' ) 두둠칫
　　　 >　⌒ヽ
　　　/ 　 へ＼
　　 /　　/　＼＼ 
　　 ﾚ　ノ　　 ヽ_つ
　　/　/두둠칫
　 /　/|
　(　(ヽ
　|　|、＼
　| 丿 ＼ ⌒)
　| |　　) /
`ノ )　　Lﾉ
"""

  robot.hear /!주사위/i, (msg) ->
    username = msg.message.user.name.toLowerCase()
    result = Math.floor(Math.random() * 6 + 1)
    delay = (ms, func) -> setTimeout func, ms
    msg.send "#{username}님이 주사위를 굴렸습니다."
    delay 1000, -> msg.send "결과 #{result}"

  robot.hear /!방/i, (msg) ->
    slack.channels(msg).then (channels) ->
      msg.send JSON.stringify(channels) + ' ' + msg.message.room
    .catch (err) ->
      msg.send "읭~ 슬랙이랑 연결 못하겠음"
