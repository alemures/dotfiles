const { spawnSync } = require('child_process');
const os = require('os');
const path = require('path');

const scriptName = path.basename(process.argv[process.argv.length - 1]);

process.on('uncaughtException', function (err) {
  alertError(err.message);
});

class XResources {
  constructor() {
    this.values = XResources.load();
  }
  /**
   * @param {string} key
   */
  get(key) {
    const value = this.values.get(key);
    if (value) {
      return value;
    }
    throw new Error(`Missing '${key}' key in XResources file`);
  }
  static load() {
    const result = run({
      command: 'xrdb',
      args: ['-query'],
    });
    /**@type {Map<string, string>} */
    const values = new Map();
    result.stdout
      .trim()
      .split(os.EOL)
      .forEach((item) => {
        const colonPosition = item.indexOf(':');
        values.set(
          item.substring(0, colonPosition).trim(),
          item.substring(colonPosition + 1).trim()
        );
      });
    return values;
  }
}

const xResources = new XResources();

const theme = {
  nord0: xResources.get('*.background'),
  nord1: xResources.get('*.color0'),
  //nord2: xResources.get("*."),
  nord3: xResources.get('*.color8'),
  nord4: xResources.get('*.foreground'),
  nord5: xResources.get('*.color7'),
  nord6: xResources.get('*.color15'),
  nord7: xResources.get('*.color14'),
  nord8: xResources.get('*.color6'),
  nord9: xResources.get('*.color12'),
  //nord10: xResources.get("*."),
  nord11: xResources.get('*.color1'),
  //nord12: xResources.get("*."),
  nord13: xResources.get('*.color11'),
  nord14: xResources.get('*.color10'),
  nord15: xResources.get('*.color13'),
};

/**
 *
 * @param {string} name
 * @param {string} [defaultValue]
 */
function getEnvVar(name, defaultValue) {
  const value = process.env[name];
  if (value !== undefined) {
    return value;
  } else if (defaultValue !== undefined) {
    return defaultValue;
  }
  throw new Error(`Missing env variable ${name}`);
}
module.exports.getEnvVar = getEnvVar;

/**
 * @param {string} message
 */
function alertInfo(message) {
  spawnSync('notify-send', ['-u', 'normal', '-t', '5000', scriptName, message]);
}
module.exports.alertInfo = alertInfo;

/**
 * @param {string} message
 */
function alertError(message) {
  spawnSync('notify-send', [
    '-u',
    'critical',
    '-t',
    '5000',
    scriptName,
    message,
  ]);
}
module.exports.alertError = alertError;

/**
 * @param {import("child_process").SpawnSyncReturns<string>} spawnResult
 * @param {string} command
 * @param {boolean} silentExit
 */
function checkExitOnFailure(spawnResult, command, silentExit) {
  if (spawnResult.status) {
    const message =
      spawnResult.stderr.trim() ||
      `Command ${command} error status: ${spawnResult.status}`;

    if (!silentExit) {
      alertError(message);
    }

    process.exit(spawnResult.status);
  }
}

module.exports.checkExitOnFailure = checkExitOnFailure;

/**
 * @param {object} param
 * @param {string} param.command
 * @param {string[]} [param.args]
 * @param {object} [param.options]
 * @param {string} [param.options.input]
 * @param {string} [param.options.cmd]
 * @param {boolean} [param.options.shell]
 * @param {boolean} [param.options.exitOnFailure]
 * @param {boolean} [param.options.silentExit]
 */
function run({ command, args = [], options = {} }) {
  /**@type {import('child_process').SpawnSyncOptionsWithStringEncoding} */
  const spawnOptions = {
    encoding: 'utf8',
    input: options.input,
    cwd: options.cmd,
    shell: options.shell,
  };

  const exitOnFailure =
    options.exitOnFailure !== undefined ? options.exitOnFailure : true;
  const silentExit =
    options.silentExit !== undefined ? options.silentExit : false;

  // Automatically add dmenu style arguments
  if (command === 'dmenu') {
    args = args.concat(getDMenuStyleArgs());
  }

  const result = spawnSync(command, args, spawnOptions);
  if (exitOnFailure) {
    checkExitOnFailure(result, command, silentExit);
  }
  return result;
}

module.exports.run = run;

function getDMenuStyleArgs() {
  const xResourcesFont = xResources.get('URxvt.font');
  // Removes "xft:" prefix
  const font = xResourcesFont.substring(4);
  return [
    '-fn',
    font,
    '-sb',
    theme.nord8,
    '-nb',
    theme.nord0,
    '-nf',
    theme.nord4,
    '-sf',
    theme.nord3,
  ];
}
