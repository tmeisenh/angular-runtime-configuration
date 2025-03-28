(function (window) {
  window.env = window.env || {};

  // Environment variables
  window["env"].FOO = "${ENV_TO_REPLACE_FOO}";
})(this);
