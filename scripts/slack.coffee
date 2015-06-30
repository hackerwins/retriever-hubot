Promise = require('bluebird');
token = process.env.SLACK_TOKEN

SLACK_API =
  CHANNEL_LIST: "https://slack.com/api/channels.list"
  CHANNEL_INFO: "https://slack.com/api/channels.info"

channels = (msg) ->
  new Promise (resolve, reject) ->
    path = SLACK_API.CHANNEL_LIST + "?token=#{token}"
    msg.http(path).get() (err, res, body) ->
      response = JSON.parse(body)
      if not response or not response.channels then reject err else resolve response.channels

members = (msg, channelId) ->
  new Promise (resolve, reject) ->
    path = SLACK_API.CHANNEL_INFO + "?token=#{token}&channel=#{channelId}"
    msg.http(path).get() (err, res, body) ->
      response = JSON.parse(body)
      if not response.members then reject else resolve response.members

module.exports =
  channels: channels
