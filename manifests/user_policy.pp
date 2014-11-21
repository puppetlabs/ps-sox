# Manage /etc/inittab
class sox::user_policy(
  $fixit = false,
) {
  if $fixit {
    augeas { "login.defs":
      context => "/files/etc/login.defs",
      changes => [
        "set PASS_MAX_DAYS 90",
        "set PASS_MIN_DAYS 7",
        "set PASS_MIN_LEN 8",
        "set PASS_WARN_AGE 14",
      ],
    }
  }
}
