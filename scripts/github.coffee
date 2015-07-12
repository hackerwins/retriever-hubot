exec = require('child_process').exec

module.exports = (robot) ->
  robot.hear /!build dist/, (msg) ->
    exec 'pwd', (error, stdout, stderr) ->
      msg.send [error, stdout, stderr].join('::')
