exec = require('child_process').exec

module.exports = (robot) ->
  robot.hear /!build dist/, (msg) ->
    exec 'git', (error, stdout, stderr) ->
      msg.send error, stdout, stderr
    exec 'pwd', (error, stdout, stderr) ->
      msg.send error, stdout, stderr
