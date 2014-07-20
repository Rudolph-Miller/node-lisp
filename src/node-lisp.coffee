spawn = require('child_process').spawn
fs = require 'fs'
path = require 'path'

class SBCL

  constructor: (fpath) ->
    basePath = path.join (path.dirname fpath), (path.basename fpath)
    lispPath = basePath + '.lisp'
    exePath = basePath + '.exe'
    if fs.exists exePath
      cmd = spawn exePath
      cmd.stdin.setEncoding 'utf-8'
      cmd.stdout.setEncoding 'utf-8'
      @stdin = cmd.stdin
      @stdout = cmd.stdout
    else
      cmd = spawn 'sbcl', ['--script', lispPath]
      cmd.stdin.setEncoding 'utf-8'
      cmd.stdout.setEncoding 'utf-8'
      @stdin = cmd.stdin
      @stdout = cmd.stdout

  write: (str) ->
    @stdin.write str
    @stdin.end()

  use: (fn) ->
    stdout = ''
    @stdout.on 'data', (data) ->
      stdout += data
    @stdout.on 'end', ->
      fn stdout.replace(/NIL/g, '')

exports.SBCL = SBCL
