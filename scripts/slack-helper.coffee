Promise = require('bluebird');
_ = require('lodash');

token = process.env.SLACK_TOKEN

SLACK_API =
  CHANNELS_LIST: "https://slack.com/api/channels.list"
  CHANNELS_INFO: "https://slack.com/api/channels.info"
  USERS_LIST: "https://slack.com/api/users.list"

channelList = (msg) ->
  new Promise (resolve, reject) ->
    msg.http(SLACK_API.CHANNELS_LIST + "?token=#{token}").get() (err, res, body) ->
      response = JSON.parse(body)
      if not response or not response.channels then reject err else resolve response.channels

channelInfo = (msg, channelId) ->
  new Promise (resolve, reject) ->
    path = SLACK_API.CHANNELS_INFO + "?token=#{token}&channel=#{channelId}"
    msg.http(path).get() (err, res, body) ->
      response = JSON.parse(body)
      if not response.channel then reject err else resolve response.channel.members

usersList = (msg, memberIds) ->
  new Promise (resolve, reject) ->
    msg.http(SLACK_API.USERS_LIST + "?token=#{token}").get() (err, res, body) ->
      response = JSON.parse(body)
      if not response.members
        reject err
      else
        resolve _.map memberIds, (memberId) ->
          member = _.find response.members, (member) -> member.id is memberId
          member.name

module.exports =
  channelList: channelList,
  memberList: (msg) ->
    channelList(msg)
    .then (channels) ->
      channel = _.find channels, (channel) -> channel.name is msg.message.room
      channelInfo(msg, channel.id)
    .then (memberIds) ->
      usersList(msg, memberIds)
