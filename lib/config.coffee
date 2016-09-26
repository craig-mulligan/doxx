path = require('path')
_ = require('lodash')

defaultConfig =
  docsExt: 'md'
  sourceDir: 'pages'
  destDir: 'contents'
  docsDir: 'pages/docs'
  templatesDir: 'templates'
  defaultTemplate: 'default.html'
  partialsDir: 'shared'
  dictionariesDir: true
  metaExtra: null
  layoutLocals: null

defaultConfigOptional =
  dictionariesDir: 'config/dictionaries'
  parseNav: 'config/navigation.txt'
  serializeNav: 'nav.json'
  buildLunrIndex: 'lunr_index.json'

resolvePathKeys = [
  'dictionariesDir'
  'parseNav'
  'serializeNav'
  'buildLunrIndex'
]

requiredKeys = [
  'rootDir'
  'sourceDir'
  'destDir'
]

module.exports = (userConfig) ->
  config = _.defaults({}, userConfig, defaultConfig)

  for key, value of defaultConfigOptional
    config[key] = value if config[key] is true

  for key in requiredKeys
    if not config[key]
      throw new Error("The key #{key} is required for Doxx config")

  for key in resolvePathKeys
    if config[key]
      config[key] = path.resolve(config.rootDir, config[key])

  if config.serializeNav and not config.parseNav
    throw new Error("parseNav key is required when serializeNav is defined in Doxx config")

  return config
