module.exports = (robot) ->
  robot.hear /!travis me (.*)/i, (msg) ->
    branch = escape(msg.match[1])
    path = "https://api.travis-ci.org/repos/summernote/summernote/branches/#{branch}"

    msg.http(path).get() (err, res, body) ->
      response = JSON.parse(body)
      if (response.file == "not found")
        msg.send "summernote:#{branch} not found"
      else
        msg.send "Build status for summernote:#{branch} #{response.branch.state}"
