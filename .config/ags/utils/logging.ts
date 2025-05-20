enum LogColor {
  RED = "\x1b[31m",
  GREEN = "\x1b[32m",
  YELLOW = "\x1b[33m",
  BLUE = "\x1b[34m",
  CYAN =  "\x1b[36m",
  RESET = "\x1b[0m",

};

enum LogString {
  TRACE = "TRACE",
  DEBUG = "DEBUG",
  INFO = "INFO",
  WARN = "WARN",
  ERROR = "ERROR",
  OFF = "OFF"
};

enum LogLevel {
  TRACE,
  DEBUG,
  INFO,
  WARN,
  ERROR,
  OFF
};

let currentLevel = LogLevel.TRACE;

function _log(level: LogLevel, label: LogString, color: LogColor, ...args: any) {
  if (level < currentLevel) return;
  const timestamp = new Date().toISOString();

  args = args.map((arg: any) => String(arg))
    .join(' ')

  const log_str = color + "[" + label + "]" + LogColor.RESET + " " + timestamp + " - " + args;
  print(log_str);
}

export function setLogLevel(level: LogLevel) {
  currentLevel = level;
}

export function trace(...args: any) { _log(LogLevel.TRACE, LogString.TRACE, LogColor.CYAN, ...args); }
export function debug(...args: any) { _log(LogLevel.DEBUG, LogString.DEBUG, LogColor.BLUE, ...args); }
export function info(...args: any)  { _log(LogLevel.INFO,  LogString.INFO,  LogColor.GREEN, ...args); }
export function warn(...args: any)  { _log(LogLevel.WARN,  LogString.WARN,  LogColor.YELLOW, ...args); }
export function error(...args: any) { _log(LogLevel.ERROR, LogString.ERROR, LogColor.RED, ...args); }
