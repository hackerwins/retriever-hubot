Promise = require('bluebird');
child = require('child_process')
exec = Promise.promisify(child.exec)

module.exports = (robot) ->
  robot.hear /!build dist/, (msg) ->
    msg.send 'Updating dist files...'
    exec('bash build-dist.sh', { cwd: process.cwd })
    .then (result) ->
      msg.send 'Update dist files: https://github.com/summernote/summernote/commits/master'
    .catch (e) ->
      msg.send 'Fail to update dist files'
