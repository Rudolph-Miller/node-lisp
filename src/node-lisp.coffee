spawn = require('child_process').spawn
fs = require 'fs'
path = require 'path'

class SBCL

  constructor: (fpath) ->
    basePath = path.join (path.dirname fpath), (path.basename fpath, '.lisp')
    lispPath = basePath + '.lisp'
    exePath = basePath + '.exe'
    if fs.existsSync exePath
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
    cmd.stderr.setEncoding 'utf-8'
    cmd.stderr.on 'data', (data) ->
      console.log data

  write: (str) ->
    try
      data = JSON.stringify str
      @stdin.write data
      @stdin.end()
    catch err
      console.log err

  use: (fn) ->
    stdout = ''
    @stdout.on 'data', (data) ->
      stdout += data
    @stdout.on 'end', ->
      data = stdout.replace(/NIL/g, '')
      try
        fn JSON.parse(data)
      catch
        fn data

exports.SBCL = SBCL
