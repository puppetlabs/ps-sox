# Manage /files/etc/login.defs
class sox::user_policy(
  $fixit = $::sox_fix,
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
    # pol2
    augeas { "/files/etc/pam.d/system-auth/01" :
      context  => "/files/etc/pam.d/system-auth",
      changes  => [
        "ins 01 after *[type='auth'][control = 'required'][module='pam_deny.so']",
        "set 01/type auth",
        "set 01/control required",
        "set 01/module pam_unix.so",
      ],
      onlyif   => "match *[type = 'auth'][control = 'required'][module = 'pam_unix.so'] size == 0",
    }

    augeas { "pam.d/system-auth" :
      context  => "/files/etc/pam.d/system-auth/*[type = 'auth'][control = 'required'][module = 'pam_unix.so']",
      changes  => [
        "rm argument",
        "set argument[1] nullok",
        "set argument[2] try_first_pass",
      ],
      require  => Augeas["/files/etc/pam.d/system-auth/01"],
    }
    sox::user_policy::pol3 {['sshd','vsftpd','login']:
      tag => 'foo',
    }
  }
}
